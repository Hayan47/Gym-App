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
          emit(ClassError(message: e.toString()));
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
          emit(ClassError(message: e.toString()));
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
          emit(ClassError(message: e.toString()));
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
          emit(ClassError(message: e.toString()));
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
          emit(ClassError(message: e.toString()));
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
          emit(ClassError(message: e.toString()));
          print(state);
        }
      },
    );
  }
}
