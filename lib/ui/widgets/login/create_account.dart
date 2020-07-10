import 'package:flow/ui/screens/register_screen.dart';
import 'package:flow/services/user_services.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {
  final UserServices _userServices;

  CreateAccount({
    Key key,
    @required UserServices userServices,
  })  : assert(userServices != null),
        _userServices = userServices,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
        style: TextStyle(
          color: Color(0xFF086FC9),
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(userServices: _userServices);
          }),
        );
      },
    );
  }
}
