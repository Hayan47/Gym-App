import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/data/services/admin_service.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    final adminService = AdminService();
    int participantsCount = 0;
    int trainersCount = 0;
    on<GetUsersCount>((event, emit) async {
      try {
        emit(AdminLoading());
        print(state);
        participantsCount = await adminService.getParticipantsCount();
        trainersCount = await adminService.getTrainersCount();
        emit(AdminLoaded(
            participantsCount: participantsCount,
            trainersCount: trainersCount));
        print(state);
      } catch (e) {
        emit(AdminError(message: e.toString()));
        print(state);
      }
    });
  }
}
