import 'package:flow/blocs/login_bloc/login_bloc.dart';
import 'package:flow/ui/widgets/login/login_form.dart';
import 'package:flow/services/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final UserServices _userServices;

  LoginScreen({
    Key key,
    @required UserServices userServices,
  })  : assert(userServices != null),
        _userServices = userServices,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userServices: _userServices),
        child: LoginForm(userServices: _userServices),
      ),
    );
  }
}
