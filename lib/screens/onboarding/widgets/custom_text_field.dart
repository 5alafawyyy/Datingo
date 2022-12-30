import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.hint,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        contentPadding: const EdgeInsets.only(
          bottom: 5.0,
          top: 12.5,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
