part of 'equipment_bloc.dart';

sealed class EquipmentState extends Equatable {
  const EquipmentState();

  @override
  List<Object> get props => [];
}

final class EquipmentInitial extends EquipmentState {}

final class EquipmentLoading extends EquipmentState {}

final class EquipmentLoaded extends EquipmentState {
  final List<Equipment> equipment;

  const EquipmentLoaded({required this.equipment});

  @override
  List<Object> get props => [equipment];
}

final class EquipmentError extends EquipmentState {
  final String message;

  const EquipmentError({required this.message});

  @override
  List<Object> get props => [message];
}

final class EquipmentAdded extends EquipmentState {
  final String message;

  const EquipmentAdded({required this.message});

  @override
  List<Object> get props => [message];
}

final class EquipmentDeleted extends EquipmentState {
  final String message;

  const EquipmentDeleted({required this.message});

  @override
  List<Object> get props => [message];
}
