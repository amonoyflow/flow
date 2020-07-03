import 'package:flutter/material.dart';

class LoginField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final String labelText;
  final IconData icon;

  LoginField({
    Key key,
    this.labelText,
    this.icon,
    this.keyboardType,
    this.obscureText = false,
    @required this.controller,
    @required this.validator,
  });

  @override
  _LoginFieldState createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: Icon(widget.icon),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 2.0
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.0
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0
            ),
          )
        ),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        autocorrect: false,
        autovalidate: true,
        validator: widget.validator,
      ),
    );
  }
}