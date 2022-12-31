import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  SwipeBloc() : super(SwipeLoadingState()) {
    on<LoadUsers>(_onLoadUsers);
    on<SwipeRight>(_onSwipeRight);
    on<SwipeLeft>(_onSwipeLeft);
  }

  FutureOr<void> _onLoadUsers(
    LoadUsers event,
    Emitter<SwipeState> emit,
  ) {
    emit(SwipeLoadedState(users: event.users));
  }

  FutureOr<void> _onSwipeRight(
    SwipeRight event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoadedState) {
      try {
        final state = this.state as SwipeLoadedState;
        emit(SwipeLoadedState(
            users: List.from(state.users)..remove(event.user)));
      } catch (_) {}
    }
  }

  FutureOr<void> _onSwipeLeft(
    SwipeLeft event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoadedState) {
      try {
        final state = this.state as SwipeLoadedState;
        emit(SwipeLoadedState(
            users: List.from(state.users)..remove(event.user)));
      } catch (_) {}
    }
  }
}
