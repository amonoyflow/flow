import 'package:flow/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flow/common/bloc_delegator.dart';
import 'package:flow/services/user_services.dart';
import 'package:flow/ui/screens/login_screen.dart';
import 'package:flow/ui/screens/splash_screen.dart';
import 'package:flow/ui/widgets/menu/dashboard_menu_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = BlocDelegator();
  final UserServices userServices = UserServices();

  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userServices: userServices,
      )..add(AuthenticationStarted()),
      child: App(userServices: userServices),
    ),
  );
}

class App extends StatelessWidget {
  final UserServices userServices;

  App({
    Key key,
    @required UserServices userServices,
  })  : assert(userServices != null),
        userServices = userServices,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationFailure) {
              return LoginScreen(userServices: userServices);
            }
            if (state is AuthenticationSuccess) {
              return DashboardMenuLayout(name: state.displayName);
            }
            return SplashScreen();
          },
        ));
  }
}
