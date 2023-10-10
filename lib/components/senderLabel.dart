import 'package:flutter/material.dart';

class SenderLabel extends StatelessWidget {
  final String text;

  const SenderLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Color(0x88000000),
              blurRadius: 4,
              offset: Offset(1, 1),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
