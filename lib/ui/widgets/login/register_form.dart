import 'package:flow/blocs/authentication_bloc/_authentication.dart';
import 'package:flow/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flow/blocs/register_bloc/_register.dart';
import 'package:flow/blocs/register_bloc/register_bloc.dart';
import 'package:flow/ui/widgets/login/login_field.dart';
import 'package:flow/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    LoginField(
                      labelText: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                    LoginField(
                      labelText: 'Password',
                      icon: Icons.lock,
                      obscureText: true,
                      controller: _passwordController,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Invalid Password'
                            : null;
                      },
                    ),
                    LoginRegisterButton(
                      labelText: 'Register',
                      onPressed: isRegisterButtonEnabled(state)
                          ? _onFormSubmitted
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        !state.isSubmitting;
  }

  void _onEmailChanged() {
    _registerBloc.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      RegisterSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
