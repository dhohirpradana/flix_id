import 'package:flix_id/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class FlixTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  const FlixTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade800)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ghostWhite)),
            labelText: labelText,
            labelStyle: const TextStyle(color: ghostWhite)));
  }
}
