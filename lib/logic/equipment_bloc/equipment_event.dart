part of 'equipment_bloc.dart';

sealed class EquipmentEvent extends Equatable {
  const EquipmentEvent();

  @override
  List<Object> get props => [];
}

class GetAllEquipment extends EquipmentEvent {}

class AddEquipmentEvent extends EquipmentEvent {
  final Equipment equipment;

  const AddEquipmentEvent({required this.equipment});
}

class DeleteEquipment extends EquipmentEvent {
  final Equipment equipment;

  const DeleteEquipment({required this.equipment});
}
