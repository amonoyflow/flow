import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;
  final IconData icon;

  SearchField({
    this.labelText,
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    @required this.controller,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(icon),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black12, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            )),
        keyboardType: keyboardType,
        obscureText: obscureText,
        autocorrect: false,
        autovalidate: true,
        validator: validator,
      ),
    );
  }
}
