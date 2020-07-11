import 'package:flow/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flow/blocs/navigation_bloc/navigation_bloc.dart';
import 'package:flow/common/flow_icons.dart';
import 'package:flow/ui/widgets/menu/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Menu extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> menuAnimation;
  final int selectedIndex;
  final Function onMenuItemClicked;

  Menu({
    Key key,
    this.slideAnimation,
    this.menuAnimation,
    this.selectedIndex,
    this.onMenuItemClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MenuItem(
                  icon: FlowIcons.home,
                  labelText: "Home",
                  onTap: onItemTap(context, NavigationHomeClickedEvent()),
                  isSelected: selectedIndex == 0,
                ),
                SizedBox(height: 40),
                MenuItem(
                  icon: FlowIcons.profile,
                  labelText: "Profile",
                  onTap: (onItemTap(context, NavigationUtilityClickedEvent())),
                  isSelected: selectedIndex == 1,
                ),
                SizedBox(height: 40),
                MenuItem(
                  icon: FlowIcons.logout,
                  labelText: "Logout",
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(AuthenticationLoggedOut());
                  },
                  isSelected: selectedIndex == 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Function onItemTap(BuildContext context, NavigationEvent event) {
    return () {
      BlocProvider.of<NavigationBloc>(context).add(event);
      onMenuItemClicked();
    };
  }
}
