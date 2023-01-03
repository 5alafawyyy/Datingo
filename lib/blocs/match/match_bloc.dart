import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
import '../../repositories/repositories.dart';

part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  final DatabaseRepository _databaseRepository;
  StreamSubscription? _databaseSubscription;

  MatchBloc({required DatabaseRepository databaseRepository})
      : _databaseRepository = databaseRepository,
        super(MatchLoadingState()) {
    on<LoadMatches>(_onLoadMatches);
    on<UpdateMatches>(_onUpdateMatches);
  }

  FutureOr<void> _onLoadMatches(LoadMatches event, Emitter<MatchState> emit) {
    _databaseSubscription =
        _databaseRepository.getMatches(event.user).listen((matchedUser) {
      if (kDebugMode) {
        print('Matched Users: $matchedUser');
      }
      add(UpdateMatches(matchedUser: matchedUser));
    });
  }

  FutureOr<void> _onUpdateMatches(
      UpdateMatches event, Emitter<MatchState> emit) {
    if (event.matchedUser.isEmpty) {
      emit(MatchUnavailableState());
    } else {
      emit(MatchLoadedState(matches: event.matchedUser));
    }
  }

  @override
  Future<void> close() async{
    _databaseSubscription?.cancel();
    super.close();
  }
}
