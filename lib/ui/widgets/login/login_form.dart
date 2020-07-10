import 'package:flow/ui/widgets/button.dart';
import 'package:flow/ui/widgets/login/create_account.dart';
import 'package:flow/ui/widgets/login/login_divider.dart';
import 'package:flow/ui/widgets/login/login_facebook.dart';
import 'package:flow/ui/widgets/login/login_field.dart';
import 'package:flow/blocs/authentication_bloc/_authentication.dart';
import 'package:flow/ui/widgets/login/login_google.dart';
import 'package:flow/blocs/login_bloc/_login.dart';
import 'package:flow/services/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final UserServices _userServices;

  LoginForm({
    Key key,
    @required UserServices userServices,
  })  : assert(userServices != null),
        _userServices = userServices,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserServices get userServices => widget._userServices;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(onEmailChanged);
    _passwordController.addListener(onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Login Failure'),
                  Icon(Icons.error),
                ],
              ),
              backgroundColor: Colors.red,
            ));
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Loggin In...'),
                  CircularProgressIndicator(),
                ],
              ),
            ));
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('flutter_logo.png'),
                    ),
                    LoginField(
                      labelText: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (_) {
                        return !state.isEmailValid 
                          ? 'Invalid Email' 
                          : null;
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
                      labelText: 'Login',
                      onPressed: isLoginEnabled(state) ? onFormSubmitted : null,
                    ),
                    LoginDivider(),
                    Row(
                      children: <Widget>[
                        LoginGoogle(),
                        SizedBox(width: 10.0),
                        LoginFacebook(),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    CreateAccount(userServices: userServices),
                    RaisedButton(
                      onPressed: () {
                        _loginBloc.add(
                          LoginWithCredentialsPressed(
                            email: "amonoyflorante@yahoo.com",
                            password: "test123456",
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool isLoginEnabled(LoginState state) {
    return state.isFormValid &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        !state.isSubmitting;
  }

  void onEmailChanged() {
    _loginBloc.add(
      LoginEmailChanged(email: _emailController.text),
    );
  }

  void onPasswordChanged() {
    _loginBloc.add(
      LoginPasswordChanged(password: _passwordController.text),
    );
  }

  void onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
