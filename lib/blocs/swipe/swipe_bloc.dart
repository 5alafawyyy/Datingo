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
        add(LoadUsers(user: state.user!));
      }
    });
  }

  FutureOr<void> _onLoadUsers(
    LoadUsers event,
    Emitter<SwipeState> emit,
  ) {
    _databaseRepository.getUsers(event.user).listen((users) {
      print('Loading Users: $users');
      if (kDebugMode) {
        print(users);
      }
      add(UpdateHome(users: users));
    });
  }

  FutureOr<void> _onUpdateHome(UpdateHome event, Emitter<SwipeState> emit) {
    if (event.users!.isNotEmpty) {
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
  ) async {
    if (state is SwipeLoadedState) {
      final state = this.state as SwipeLoadedState;
      String userId = _authBloc.state.authUser!.uid;
      List<User> users = List.from(state.users)..remove(event.user);

      await _databaseRepository.updateUserSwipe(
        userId,
        event.user.id!,
        true,
      );

      if (event.user.swipeRight!.contains(userId)) {
        await _databaseRepository.updateUserMatch(
          userId,
          event.user.id!,
        );
        emit(SwipeMatchedState(user: event.user));
      } else if (users.isNotEmpty) {
        emit(SwipeLoadedState(users: users));
      } else {
        emit(SwipeErrorState());
      }
    }
  }

  FutureOr<void> _onSwipeLeft(
    SwipeLeft event,
    Emitter<SwipeState> emit,
  ) async {
    if (state is SwipeLoadedState) {
      final state = this.state as SwipeLoadedState;
      String userId = _authBloc.state.authUser!.uid;
      List<User> users = List.from(state.users)..remove(event.user);

      await _databaseRepository.updateUserSwipe(
        userId,
        event.user.id!,
        false,
      );

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
