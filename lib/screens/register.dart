import 'package:flutter/material.dart';
import 'package:quick_messenger/components/circular_border_button.dart';
import 'package:quick_messenger/components/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_messenger/constants/screens.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _auth = FirebaseAuth.instance;

  String email = "";
  String password = "";
  bool loading = false;

  void handleRegister() async {
    setState(() { loading = true; });
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(!context.mounted) return;
      Navigator.pushNamed(context, Screens.chat);
    }
    catch(e){
      Alert(
        context: context,
        title: "Error",
        desc: "Unvalid inputs. Please try again.",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.indigo,
            height: 45,
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ).show();
    }
    setState(() { loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      blur: 0.9,
      opacity: 0.9,
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
                          "Register",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        CustomInput(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (e) { email = e.toString(); },
                          color: Colors.indigo,
                          placeholder: "Email",
                        ),
                        const SizedBox(height: 15),
                        CustomInput(
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (e) { password = e.toString(); },
                          color: Colors.indigo,
                          placeholder: "Password",
                        ),
                        const SizedBox(height: 25),
                        CircularBorderButton(
                          buttonColor: Colors.indigo,
                          buttonTitle: "Register",
                          onTap: handleRegister,
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
