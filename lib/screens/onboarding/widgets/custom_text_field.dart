import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  const CustomTextField({
    Key? key,
    required this.hint,
    this.controller,
    this.onSubmitted,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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
      controller: controller,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      onEditingComplete: () {},
      keyboardType: keyboardType,
    );
  }
}
