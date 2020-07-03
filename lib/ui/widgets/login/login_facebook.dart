import 'package:flow/blocs/login_bloc/_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RaisedButton.icon(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        color: Color(0xFF3B5998),
        icon: Icon(
          Icons.lock, 
          color: Colors.white,
          size: 16.0,
        ),
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(LoginWithFacebookPressed());
        },
        label: Text(
          'Facebook', 
          style: TextStyle(color: Colors.white)
        ),
      ),
    );
  }
}