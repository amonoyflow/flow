import 'package:flow/ui/widgets/login/register_form.dart';
import 'package:flow/blocs/register_bloc/_register.dart';
import 'package:flow/services/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final UserServices _userServices;

  RegisterScreen({
    Key key,
    @required UserServices userServices,
  })
  : assert(userServices != null),
    _userServices = userServices,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userServices: _userServices),
          child: RegisterForm(),
        ),
      ),
    );
  }
}