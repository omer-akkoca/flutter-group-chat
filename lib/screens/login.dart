import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quick_messenger/components/circular_border_button.dart';
import 'package:quick_messenger/components/input.dart';
import 'package:quick_messenger/constants/screens.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;

  String email = "";
  String password = "";
  bool loading = false;

  void handleLogin() async {
    setState(() { loading = true; });
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!context.mounted) return;
        Navigator.pushNamed(context, Screens.chat);
    } catch (e) {
      Alert(
        context: context,
        title: "Error",
        desc: "Unexist user. Please check your login inputs.",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.blue,
            height: 45,
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          DialogButton(
            onPressed: () => Navigator.pushNamed(context, Screens.register),
            color: Colors.indigo,
            height: 45,
            child: const Text(
              "Register",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ).show();
    }
    setState(() { loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 55,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.black87,
                          size: 50,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Hero(
                          tag: "logo",
                          child: Image(
                            image: AssetImage("assets/images/logo.png"),
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Log In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        CustomInput(
                          onChanged: (e) {
                            email = e.toString();
                          },
                          color: Colors.blue,
                          placeholder: "Email",
                        ),
                        const SizedBox(height: 15),
                        CustomInput(
                          onChanged: (e) {
                            password = e.toString();
                          },
                          color: Colors.blue,
                          placeholder: "Password",
                        ),
                        const SizedBox(height: 25),
                        CircularBorderButton(
                          buttonColor: Colors.blue,
                          buttonTitle: "Log In",
                          onTap: handleLogin,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
