import 'package:flutter/material.dart';

class LoginRegisterButton extends StatelessWidget {
  final String _labelText;
  final VoidCallback _onPressed;

  LoginRegisterButton({
    Key key,
    String labelText,
    VoidCallback onPressed,
  })
  : _onPressed = onPressed,
    _labelText = labelText,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 30.0, bottom: 10.0),
      child: RaisedButton(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        color: Color(0xFF086FC9),
        onPressed: _onPressed,
        disabledColor: Color(0x80086FC9),
        child: Text(
          _labelText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}