import 'package:flutter/material.dart';

class Custom_TextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const Custom_TextField(
      {super.key, 
        required this.controller, 
        required this.hint, 
        this.maxLines = 1,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty){
          return 'Enter your $hint';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
