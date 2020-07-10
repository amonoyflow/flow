import 'dart:ui';
import 'package:flow/blocs/navigation_bloc/_navigation.dart';
import 'package:flow/ui/screens/home_screen.dart';
import 'package:flow/ui/screens/utility_screen.dart';
import 'package:flow/ui/widgets/menu/dashboard.dart';
import 'package:flow/ui/widgets/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardMenuLayout extends StatefulWidget {
  final String name;

  DashboardMenuLayout({this.name});

  @override
  _DashboardMenuLayoutState createState() => _DashboardMenuLayoutState();
}

class _DashboardMenuLayoutState extends State<DashboardMenuLayout>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  Duration duration = const Duration(milliseconds: 200);
  AnimationController controller;
  Animation<double> scaleAnimation;
  Animation<double> menuScaleAnimation;
  Animation<Offset> slideAnimation;
  Animation<Offset> slideAboveAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration);
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(controller);
    menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(controller);
    slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
      .animate(controller);
    slideAboveAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
      .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Color(0xFF28282D),
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(onMenuTap: onMenuTap),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              SlideTransition(
                position: slideAboveAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 40,
                        color: Colors.white,
                        onPressed: () { onMenuItemClicked(); },
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, NavigationState navigationState) {
                  return Menu(
                    slideAnimation: slideAnimation,
                    menuAnimation: menuScaleAnimation,
                    selectedIndex: findSelectedIndex(navigationState),
                    onMenuItemClicked: onMenuItemClicked,
                  );
                },
              ),
              Dashboard(
                duration: duration,
                onMenuTap: onMenuTap,
                scaleAnimation: scaleAnimation,
                isCollapsed: isCollapsed,
                screenWidth: screenWidth,
                child: BlocBuilder<NavigationBloc, NavigationState>(
                  builder: (context, NavigationState navigationState) {
                    return navigationState as Widget;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onMenuTap() {
    setState(() {
      isCollapsed ? controller.forward() : controller.reverse();
      isCollapsed = !isCollapsed;
    });
  }

  void onMenuItemClicked() {
    setState(() {
      controller.reverse();
    });

    isCollapsed = !isCollapsed;
  }

  int findSelectedIndex(NavigationState navigationState) {
    if (navigationState is HomeScreen) {
      return 0;
    } else if (navigationState is UtilityScreen) {
      return 1;
    } else if (navigationState is UtilityScreen) {
      return 2;
    }
    return 0;
  }
}
