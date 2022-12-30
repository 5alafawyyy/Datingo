part of 'auth_bloc.dart';

enum AuthStatus { unKnown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final auth.User? user;

  const AuthState._({
    this.status = AuthStatus.unKnown,
    this.user,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated({required auth.User user})
      : this._(
          status: AuthStatus.authenticated,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  @override
  List<Object?> get props => [
        status,
        user,
      ];
}
