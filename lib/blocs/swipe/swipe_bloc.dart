import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoadingState());

  @override
  Stream<SwipeState> mapEventToState(
    SwipeEvent event,
  ) async* {
    if (event is LoadUsersEvent) {
      yield* _mapLoadUsersToState(event);
    }
    if (event is SwipeLeftEvent) {
      yield* _mapSwipeLeftToState(event, state);
    }
    if (event is SwipeRightEvent) {
      yield* _mapSwipeRightToState(event, state);
    }
  }

  Stream<SwipeState> _mapLoadUsersToState(LoadUsersEvent event) async* {
    yield SwipeLoadedState(users: event.users);
  }

  Stream<SwipeState> _mapSwipeLeftToState(
      SwipeLeftEvent event, SwipeState state) async* {
    if (state is SwipeLoadedState) {
      try {
        yield SwipeLoadedState(
            users: List.from(state.users)..remove(event.user));
      } catch (_) {}
    }
  }

  Stream<SwipeState> _mapSwipeRightToState(
      SwipeRightEvent event, SwipeState state) async* {
    if (state is SwipeLoadedState) {
      try {
        yield SwipeLoadedState(
            users: List.from(state.users)..remove(event.user));
      } catch (_) {}
    }
  }
}


/*
class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoading()) {
    on<LoadUsersEvent>(_onLoadUserEvent);
    on<SwipeLeftEvent>(_onSwipeLeftEvent);
    on<SwipeRightEvent>(_onSwipeRightEvent);
  }

  FutureOr<void> _onLoadUserEvent(
      LoadUsersEvent event, Emitter<SwipeState> emit) async* {
    yield* _mapLoadUsersToState(event);
  }

  FutureOr<void> _onSwipeLeftEvent(
      SwipeLeftEvent event, Emitter<SwipeState> emit) async* {
    yield* _mapSwipeLeftToState(event, state);
  }

  FutureOr<void> _onSwipeRightEvent(
      SwipeRightEvent event, Emitter<SwipeState> emit) async* {
    yield* _mapSwipeRightToState(event, state);
  }

  Stream<SwipeState> _mapLoadUsersToState(LoadUsersEvent event) async* {
    yield SwipeLoaded(users: event.users);
  }

  Stream<SwipeState> _mapSwipeLeftToState(
      SwipeLeftEvent event, SwipeState state) async* {
    if (state is SwipeLoaded) {
      try {
        yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
      } catch (_) {}
    }
  }

  Stream<SwipeState> _mapSwipeRightToState(
      SwipeRightEvent event, SwipeState state) async* {
    if (state is SwipeLoaded) {
      try {
        yield SwipeLoaded(users: List.from(state.users)..remove(event.user));
      } catch (_) {}
    }
  }
}
*/