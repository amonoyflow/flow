import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BeveragesSelection extends StatelessWidget {
  final String asset;
  final String label;

  BeveragesSelection({
    this.asset,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      color: Color(0x1AAAE5EE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Color(0x33AAE5EE))
      ),
      onPressed: () {},
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(asset, height: 40),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14, 
                  color: Color(0xFF43AAC2),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
