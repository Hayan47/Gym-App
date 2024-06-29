part of 'schedule_bloc.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

final class ScheduleInitial extends ScheduleState {}

final class ScheduleLoading extends ScheduleState {}

final class ScheduleLoaded extends ScheduleState {
  final List<DateTime> holydays;

  const ScheduleLoaded({required this.holydays});
}

final class ScheduleAdded extends ScheduleState {
  final String message;

  const ScheduleAdded({required this.message});
}

final class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError({required this.message});
}
