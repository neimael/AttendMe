import 'dart:async';

import 'package:attend_me/Screens/qr_scanner_overlay.dart';
import 'package:attend_me/Screens/success_checkin_page.dart';
import 'package:attend_me/Screens/success_presence_page.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanCompleted = false;
  Timer? scanDelayTimer; // Timer variable to introduce a delay
  void closeScreen() {
    isScanCompleted = false;
  }

  bool isFlashOn = false;
  MobileScannerController controller = MobileScannerController();

  void showAlert(BuildContext context) {
    if (context == null) {
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Attention !',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          content:
              Text('Please Scan the same Qr Code as the checkin\'s Qr Code'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                isScanCompleted =
                    true; // Set isScanCompleted to true immediately

                scanDelayTimer?.cancel(); // Cancel any existing timer
                scanDelayTimer = Timer(const Duration(seconds: 5), () {
                  // After a delay of 2 seconds, reset the isScanCompleted flag
                  resetScan();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void resetScan() {
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });

                controller.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? maincolor : Colors.grey,
              )),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Padding(
          padding: EdgeInsets.only(left: screenSize.width * 0.08),
          child: Text(
            'Scanning Qr Code',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: const Color.fromARGB(255, 133, 118, 118),
                fontSize: screenSize.width * 0.05),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 133, 118, 118)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 1,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(screenSize.height * 0.03),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Place the QR code inside the frame",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 75, 72, 72),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Text(
                    "Scanning will be started automatically",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.043,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 163, 158, 158),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: controller,
                    allowDuplicates: true,
                    onDetect: (Barcode, args) async {
                      if (!isScanCompleted) {
                        String code = Barcode.rawValue ?? '---';
                        isScanCompleted = true;
                        String? status;

                        // Retrieve the value of 'status' from SharedPreferences
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        status = prefs.getString('status');

                        if (status == "checkIn") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SucessCheckinPage(
                                  code: code, closeScreen: closeScreen),
                            ),
                          );
                        } else if (status == "checkOut") {
                          int? qrCodeIdOld;

                          // Retrieve the value of 'qr_code_id' from SharedPreferences
                          qrCodeIdOld = prefs.getInt('qr_code_id');

                          final List<String> codeParts =
                              code.split('QR Code ID: ');
                          final String idQrCode =
                              codeParts.length > 1 ? codeParts[1] : '';
                          int? qrCodeIdNew = int.tryParse(idQrCode);

                          if (qrCodeIdNew != null &&
                              qrCodeIdOld == qrCodeIdNew) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SuccessPresencePage(),
                              ),
                            );
                          } else {
                            showAlert(context);
                          }
                        }
                      }
                    },
                  ),

                  // Display the QR code overlay

                  const QRScannerOverlay(
                    overlayColour: Color.fromARGB(255, 255, 255, 255),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  ". . . . . . . . . . ",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 163, 158, 158),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
