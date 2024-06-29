part of 'admin_bloc.dart';

sealed class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

final class AdminInitial extends AdminState {}

final class AdminLoading extends AdminState {}

final class AdminLoaded extends AdminState {
  final int participantsCount;
  final int trainersCount;

  const AdminLoaded(
      {required this.participantsCount, required this.trainersCount});
}

final class AdminError extends AdminState {
  final String message;

  const AdminError({required this.message});
}
