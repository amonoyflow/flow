import 'package:flow/blocs/navigation_bloc/_navigation.dart';
import 'package:flow/ui/screens/home_screen.dart';
import 'package:flow/ui/screens/utility_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final Function onMenuTap;

  NavigationBloc({
    this.onMenuTap,
  });

  @override
  NavigationState get initialState => HomeScreen(
        onMenuTap: onMenuTap,
      );

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigationHomeClickedEvent) {
      yield HomeScreen(onMenuTap: onMenuTap);
    } else if (event is NavigationUtilityClickedEvent) {
      yield UtilityScreen(onMenuTap: onMenuTap);
    }
  }
}
