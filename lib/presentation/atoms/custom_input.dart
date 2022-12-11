import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({Key? key, required this.icon, required this.hint})
      : super(key: key);

  final IconData icon;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hint,
          fillColor: Colors.grey.shade200,
          filled: true,
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none)),
    );
  }
}
