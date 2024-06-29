part of 'schedule_bloc.dart';

sealed class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetHolyDays extends ScheduleEvent {}

class AddHolyDays extends ScheduleEvent {
  final List<DateTime> holydays;

  const AddHolyDays({required this.holydays});
}
