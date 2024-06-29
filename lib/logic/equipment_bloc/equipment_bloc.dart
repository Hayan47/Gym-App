import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/data/models/equipment_model.dart';
import 'package:gym/data/services/equipment_service.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  final equipmentService = EquipmentService();
  List<Equipment> equipmentList = [];
  EquipmentBloc() : super(EquipmentInitial()) {
    on<GetAllEquipment>(
      (event, emit) async {
        try {
          emit(EquipmentLoading());
          print(state);
          equipmentList = await equipmentService.getAllEquipment();
          emit(EquipmentLoaded(equipment: equipmentList));
          print(state);
        } catch (e) {
          emit(EquipmentError(message: e.toString()));
          print(state);
        }
      },
    );

    on<AddEquipmentEvent>(
      (event, emit) async {
        try {
          emit(EquipmentLoading());
          await equipmentService.addEquipment(event.equipment);
          emit(const EquipmentAdded(message: 'Equipment Added Successfully'));
          // add(GetAllCarsEvent());
          print(state);
        } catch (e) {
          emit(EquipmentError(message: e.toString()));
          print(state);
        }
      },
    );

    on<DeleteEquipment>(
      (event, emit) async {
        try {
          await equipmentService.deleteEquipment(event.equipment);
          emit(const EquipmentDeleted(
              message: 'Equipment Deleted Successfully'));
          // add(GetAllCarsEvent());
          print(state);
        } catch (e) {
          emit(EquipmentError(message: e.toString()));
          print(state);
        }
      },
    );
  }
}
