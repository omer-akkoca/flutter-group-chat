import 'package:flutter/material.dart';
import 'package:quick_messenger/constants/screens.dart';
import 'package:quick_messenger/screens/Chat.dart';
import 'package:quick_messenger/screens/Login.dart';
import 'package:quick_messenger/screens/Register.dart';
import 'package:quick_messenger/screens/Welcome.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(const QuickMessenger());
}

class QuickMessenger extends StatelessWidget {
  const QuickMessenger({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Screens.welcome,
      routes: {
        Screens.chat: (context) => const Chat(),
        Screens.login: (context) => const Login(),
        Screens.register: (context) => const Register(),
        Screens.welcome: (context) => const Welcome(),
      },
    );
  }
}
