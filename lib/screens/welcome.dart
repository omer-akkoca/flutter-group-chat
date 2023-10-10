import 'package:flutter/material.dart';
import 'package:quick_messenger/components/circular_border_button.dart';
import 'package:quick_messenger/constants/screens.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Hero(
                  tag: "logo",
                  child: Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 65,
                    height: 65,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 5),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Quick Messenger",
                      textStyle: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        letterSpacing: 1,
                      ),
                      speed: const Duration(milliseconds: 100)
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            CircularBorderButton(
              buttonColor: Colors.blue,
              buttonTitle: "Log In",
              onTap: () {
                Navigator.pushNamed(context, Screens.login);
              },
            ),
            const SizedBox(height: 25),
            CircularBorderButton(
              buttonColor: Colors.indigo,
              buttonTitle: "Register",
              onTap: () {
                Navigator.pushNamed(context, Screens.register);
              },
            ),
          ],
        ),
      ),
    );
  }
}
