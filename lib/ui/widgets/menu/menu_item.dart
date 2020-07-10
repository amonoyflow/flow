import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Function onTap;
  final String labelText;
  final IconData icon;
  final bool isSelected;

  MenuItem({this.onTap, this.labelText, this.icon, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Icon(
              icon,
              size: 26,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 24.0),
          Text(
            labelText,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontSize: 22,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
