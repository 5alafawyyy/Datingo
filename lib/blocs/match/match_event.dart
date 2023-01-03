// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'match_bloc.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

class LoadMatches extends MatchEvent {
  final User user;

  const LoadMatches({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UpdateMatches extends MatchEvent {
  final List<Match> matchedUser;

  const UpdateMatches({
    required this.matchedUser,
  });

  @override
  List<Object> get props => [matchedUser];
}
