import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gym/data/models/class_model.dart';
import 'package:gym/data/services/class_service.dart';

part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final classService = ClassService();
  List<GymClass> allClasses = [];
  List<GymClass> trainerClasses = [];
  List<GymClass> participantClasses = [];
  List<GymClass> pendingClasses = [];
  ClassBloc() : super(ClassInitial()) {
    on<GetAllClasses>(
      (event, emit) async {
        try {
          emit(ClassLoading());
          print(state);
          allClasses = await classService.getAllClasses();
          emit(ClassLoaded(gymclasses: allClasses));
          print(state);
        } catch (e) {
          emit(const ClassError(message: "error getting classes"));
          print(state);
        }
      },
    );

    on<AddClass>(
      (event, emit) async {
        try {
          emit(ClassLoading());
          await classService.addClass(event.gymclass);
          emit(const ClassAdded(message: 'Class Added Successfully'));
          // add(GetAllCarsEvent());
          print(state);
        } catch (e) {
          emit(const ClassError(message: "error adding class"));
          print(state);
        }
      },
    );

    on<DeleteClass>(
      (event, emit) async {
        try {
          await classService.deleteClass(event.gymclass);
          emit(const ClassDeleted(message: 'Class Deleted Successfully'));
          // add(GetAllCarsEvent());
          print(state);
        } catch (e) {
          emit(const ClassError(message: "error deleting class"));
          print(state);
        }
      },
    );

    on<GetTrainerClasses>(
      (event, emit) async {
        try {
          emit(ClassLoading());
          print(state);
          trainerClasses =
              await classService.getTrainerClasses(event.trainerId);
          emit(ClassLoaded(gymclasses: trainerClasses));
          print(state);
        } catch (e) {
          emit(const ClassError(message: "error getting classes"));
          print(state);
        }
      },
    );

    on<GetParticipantClasses>(
      (event, emit) async {
        try {
          emit(ClassLoading());
          print(state);
          participantClasses =
              await classService.getParticipantClasses(event.participantId);
          emit(ClassLoaded(gymclasses: participantClasses));
          print(state);
        } catch (e) {
          emit(const ClassError(message: "error getting classes"));
          print(state);
        }
      },
    );

    on<JoinClass>(
      (event, emit) async {
        try {
          emit(ClassLoading());
          print(state);
          await classService.joinClass(event.classId, event.userId);
          emit(const ClassJoined(message: 'class joined successfully'));
          print(state);
        } catch (e) {
          emit(const ClassError(message: "error joining class"));
          print(state);
        }
      },
    );

    on<GetPendingClasses>(
      (event, emit) async {
        try {
          emit(ClassLoading());
          print(state);
          pendingClasses = await classService.getPendingClasses();
          emit(ClassLoaded(gymclasses: pendingClasses));
          print(state);
        } catch (e) {
          emit(const ClassError(message: "error getting classes"));
          print(state);
        }
      },
    );

    on<UpdateGymClassState>(
      (event, emit) async {
        try {
          emit(ClassLoading());
          print(state);
          await classService.updateGymClassState(event.classid, event.newState);
          if (event.newState == "approved") {
            emit(const ClassUpdated(message: 'class approved'));
          } else {
            emit(const ClassUpdated(message: 'class rejected'));
          }
          print(state);
        } catch (e) {
          emit(const ClassError(message: "error updating class state"));
          print(state);
        }
      },
    );
  }
}
