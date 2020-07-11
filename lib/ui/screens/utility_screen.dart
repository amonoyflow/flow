import 'package:flow/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class UtilityScreen extends StatefulWidget with NavigationState {
  final Function onMenuTap;

  UtilityScreen({
    Key key,
    this.onMenuTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UtilityState();
}

class _UtilityState extends State<UtilityScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    child: Icon(Icons.menu, size: 30),
                    onTap: widget.onMenuTap,
                  ),
                  Text("Utility",
                      style: TextStyle(fontSize: 24, color: Colors.black)),
                  Icon(Icons.settings, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
