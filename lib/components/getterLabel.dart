import 'package:flutter/material.dart';

class GetterLabel extends StatelessWidget {
  final String text;
  final String sender;

  const GetterLabel({super.key, required this.text, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(sender),
          const SizedBox(height: 6),
          Container(
            margin: const EdgeInsets.only(bottom: 25),
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x88000000),
                  blurRadius: 4,
                  offset: Offset(1, 1)
                )
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
