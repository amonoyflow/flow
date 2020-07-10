import 'package:flutter/material.dart';

class LoginDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.04),
      width: size.width,
      child: Row(
        children: <Widget>[
          divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "or sign-in with",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          divider(),
        ],
      ),
    );
  }

  Expanded divider() {
    return Expanded(
      child: Divider(
        color: Colors.grey,
        height: 1.5,
      ),
    );
  }
}
