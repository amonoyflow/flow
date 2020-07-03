import 'package:flow/blocs/login_bloc/_login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RaisedButton.icon(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        color: Color(0xFFDB4437),
        icon: Icon(
          Icons.lock, 
          color: Colors.white,
          size: 16.0,
        ),
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
        },
        label: Text(
          'Google', 
          style: TextStyle(color: Colors.white)
        ),
      ),
    );
  }
}