part of 'match_bloc.dart';

abstract class MatchState extends Equatable {
  const MatchState();

  @override
  List<Object> get props => [];
}

class MatchLoadingState extends MatchState {}

class MatchLoadedState extends MatchState {
  final List<Match> matches;

  const MatchLoadedState({required this.matches});
}

class MatchUnavailableState extends MatchState {}
