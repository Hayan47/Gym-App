part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthState {
  final User user;

  const Authenticated({required this.user});
}

final class NotAuthenticated extends AuthState {}
