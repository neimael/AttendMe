import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:attend_me/Screens/Login_page.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final formKey = GlobalKey<FormState>();
  bool _isTappedPass = false;
  bool _hideText = true;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Gap(screenSize.height * 0.07),
                Text(
                  "Change your password ",
                  style: TextStyle(
                    fontSize: screenSize.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 110, 110, 110),
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(screenSize.height * 0.01),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.03,
                        vertical: screenSize.height * 0.03),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            padding: EdgeInsets.all(screenSize.height * 0.043),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6096B4),
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 80,
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 4),
                            child: Container(
                                height: 210,
                                width: 210,
                                child: Center(
                                    child: Image.asset("assets/newPass.png"))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(screenSize.height * 0.01),
                Column(
                  children: [
                    Text(
                      " Your identity has been identified ! \n Please set a new password ",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.05,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 163, 158, 158),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Gap(screenSize.height * 0.03),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: TextFormField(
                    onTap: () {
                      setState(() {
                        _isTappedPass = true;
                      });
                    },
                    obscureText: _hideText,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      labelStyle: TextStyle(
                        color: _isTappedPass
                            ? const Color(0xFF6096B4)
                            : const Color.fromARGB(255, 112, 112, 112),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF6096B4),
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF6096B4),
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hideText ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFF6096B4),
                        ),
                        onPressed: () {
                          setState(() {
                            _hideText = !_hideText;
                          });
                        },
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFF6096B4),
                      ),
                    ),
                  ),
                ),
                Gap(screenSize.height * 0.02),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: TextFormField(
                    onTap: () {
                      setState(() {
                        _isTappedPass = true;
                      });
                    },
                    obscureText: _hideText,
                    decoration: InputDecoration(
                      labelText: " Confirm New Password",
                      labelStyle: TextStyle(
                        color: _isTappedPass
                            ? const Color(0xFF6096B4)
                            : const Color.fromARGB(255, 112, 112, 112),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF6096B4),
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF6096B4),
                          width: 2.0,
                          style: BorderStyle.solid,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _hideText ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFF6096B4),
                        ),
                        onPressed: () {
                          setState(() {
                            _hideText = !_hideText;
                          });
                        },
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFF6096B4),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                SizedBox(
                  width: screenSize.width * 0.5,
                  height: screenSize.height * 0.07,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6096B4),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenSize.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
