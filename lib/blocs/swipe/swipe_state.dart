// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'swipe_bloc.dart';

abstract class SwipeState extends Equatable {
  const SwipeState();

  @override
  List<Object> get props => [];
}

class SwipeLoadingState extends SwipeState {}

class SwipeLoadedState extends SwipeState {
  final List<User> users;

  const SwipeLoadedState({
    required this.users,
  });

  @override
  List<Object> get props => [users];
}

class SwipeMatchedState extends SwipeState {
  final User user;

  const SwipeMatchedState({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class SwipeErrorState extends SwipeState {}
