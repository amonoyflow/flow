part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationHomeClickedEvent extends NavigationEvent {}

class NavigationMessagesClickedEvent extends NavigationEvent {}

class NavigationUtilityClickedEvent extends NavigationEvent {}
