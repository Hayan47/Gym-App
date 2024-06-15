part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final Usr userInfo;
  // final List<Reservation> reservation;
  // final List<Car> cars;

  const UserLoaded({
    required this.userInfo,
    // required this.cars,
    // this.reservation,
  });
}

class UserError extends UserState {
  final String errorMessage;

  const UserError(this.errorMessage);
}
