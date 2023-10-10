import 'package:flutter/material.dart';

class CircularBorderButton extends StatefulWidget {
  final Color buttonColor;
  final String buttonTitle;
  final Function onTap;

  const CircularBorderButton({
    super.key,
    required this.buttonColor,
    required this.buttonTitle,
    required this.onTap,
  });

  @override
  State<CircularBorderButton> createState() => _State();
}

class _State extends State<CircularBorderButton> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(99),
          boxShadow: const [
            BoxShadow(
              color: Color(0x55000000),
              offset: Offset(0, 3),
              blurRadius: 8,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            widget.buttonTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}