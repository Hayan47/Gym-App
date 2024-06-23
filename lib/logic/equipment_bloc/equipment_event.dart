part of 'equipment_bloc.dart';

sealed class EquipmentEvent extends Equatable {
  const EquipmentEvent();

  @override
  List<Object> get props => [];
}

class GetAllEquipment extends EquipmentEvent {}

class AddEquipment extends EquipmentEvent {
  final Equipment equipment;

  const AddEquipment({required this.equipment});
}

class DeleteEquipment extends EquipmentEvent {
  final Equipment equipment;

  const DeleteEquipment({required this.equipment});
}
