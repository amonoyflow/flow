import 'package:equatable/equatable.dart';
import 'package:flow/ui/screens/home_screen.dart';
import 'package:flow/ui/screens/utility_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

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
