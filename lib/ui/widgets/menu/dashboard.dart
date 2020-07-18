import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final bool isCollapsed;
  final double screenWidth;
  final Duration duration;
  final Function onMenuTap;
  final Widget child;

  Dashboard({
    Key key,
    this.isCollapsed,
    this.screenWidth,
    this.duration,
    this.onMenuTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.7 * screenWidth,
      right: isCollapsed ? 0 : -0.7 * screenWidth,
      child: Material(
        animationDuration: duration,
        elevation: 8,
        child: child,
      ),
    );
  }
}
