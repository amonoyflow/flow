import 'package:flow/services/user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserServices _userServices;

  AuthenticationBloc({@required UserServices userServices})
      : assert(userServices != null),
        _userServices = userServices;

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationState> mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userServices.isSignedIn();
    if (isSignedIn) {
      final name = await _userServices.getUser();
      yield AuthenticationSuccess(name);
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess(await _userServices.getUser());
  }

  Stream<AuthenticationState> mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailure();
    _userServices.signOut();
  }
}
