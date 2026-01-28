part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}


class AuthLogoutRequested extends AuthEvent {}
class AuthCheckStatus extends AuthEvent {}