import "package:flutter/material.dart";

class CustomInput extends StatefulWidget {

  late Function onChanged;
  late Color color;
  late String placeholder;
  final TextInputType keyboardType = TextInputType.text;

  CustomInput({
    super.key,
    required this.onChanged,
    required this.color,
    required this.placeholder,
    TextInputType keyboardType = TextInputType.text,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      onChanged: (e) { widget.onChanged(e); },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.color, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(99)),
        ),
        hintText: widget.placeholder,
        hintStyle: const TextStyle(color: Colors.black45),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.color, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(99)),
        ),
      ),
      cursorColor: Colors.blue,
    );
  }
}
