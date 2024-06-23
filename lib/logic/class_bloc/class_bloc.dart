import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gym/data/models/class_model.dart';
import 'package:gym/data/services/class_service.dart';

part 'class_event.dart';
part 'class_state.dart';

class ClassBloc extends Bloc<ClassEvent, ClassState> {
  final classService = ClassService();
  List<GymClass> classes = [];
  ClassBloc() : super(ClassInitial()) {
    on<GetAllClasses>(
      (event, emit) async {
        try {
          emit(ClassLoading());
          print(state);
          classes = await classService.getAllClasses();
          emit(ClassLoaded(gymclasses: classes));
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
  }
}
