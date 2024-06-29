import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/data/models/schedule_model.dart';
import 'package:gym/data/services/schedule_service.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final scheduleService = ScheduleService();
  List<Schedule> schedules = [];
  List<DateTime> holydays = [];
  ScheduleBloc() : super(ScheduleInitial()) {
    on<GetHolyDays>(
      (event, emit) async {
        try {
          emit(ScheduleLoading());
          print(state);
          schedules = await scheduleService.getHolidays();
          for (var schedule in schedules) {
            holydays.add(schedule.holyday);
          }
          emit(ScheduleLoaded(holydays: holydays));
          print(state);
        } catch (e) {
          emit(ScheduleError(message: e.toString()));
          print(state);
          print(e);
        }
      },
    );

    on<AddHolyDays>(
      (event, emit) async {
        try {
          emit(ScheduleLoading());
          await scheduleService.addMultipleHolidays(event.holydays);
          emit(const ScheduleAdded(message: 'Holydays Added Successfully'));
          print(state);
        } catch (e) {
          emit(ScheduleError(message: e.toString()));
          print(state);
        }
      },
    );
  }
}
