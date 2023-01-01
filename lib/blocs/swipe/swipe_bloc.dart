import 'dart:async';
import 'package:datingo/blocs/auth/auth_bloc.dart';
import 'package:datingo/repositories/database/database_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final AuthBloc _authBloc;
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _authSubscription;
  SwipeBloc({
    required AuthBloc authBloc,
    required DatabaseRepository databaseRepository,
  })  : _authBloc = authBloc,
        _databaseRepository = databaseRepository,
        super(SwipeLoadingState()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateHome>(_onUpdateHome);
    on<SwipeRight>(_onSwipeRight);
    on<SwipeLeft>(_onSwipeLeft);

    _authSubscription = _authBloc.stream.listen((state) {
      if (state.status == AuthStatus.authenticated) {
        add(LoadUsers(userId: state.user!.uid));
      }
    });
  }

  FutureOr<void> _onLoadUsers(
    LoadUsers event,
    Emitter<SwipeState> emit,
  ) {
    _databaseRepository.getUsers(event.userId, 'Male').listen((users) {
      if (kDebugMode) {
        print(users);
      }
      add(UpdateHome(users: users));
    });
  }

  FutureOr<void> _onUpdateHome(UpdateHome event, Emitter<SwipeState> emit) {
    if (event.users != null) {
      emit(
        SwipeLoadedState(users: event.users!),
      );
    } else {
      emit(
        SwipeErrorState(),
      );
    }
  }

  FutureOr<void> _onSwipeRight(
    SwipeRight event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoadedState) {
      final state = this.state as SwipeLoadedState;
      List<User> users = List.from(state.users)..remove(event.user);

      if (users.isNotEmpty) {
        emit(SwipeLoadedState(users: users));
      } else {
        emit(SwipeErrorState());
      }
    }
  }

  FutureOr<void> _onSwipeLeft(
    SwipeLeft event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoadedState) {
      final state = this.state as SwipeLoadedState;
      List<User> users = List.from(state.users)..remove(event.user);

      if (users.isNotEmpty) {
        emit(SwipeLoadedState(users: users));
      } else {
        emit(SwipeErrorState());
      }
    }
  }

  Future<void> onClose() async {
    _authSubscription?.cancel();
    super.close();
  }
}
