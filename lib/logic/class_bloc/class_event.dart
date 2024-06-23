part of 'class_bloc.dart';

sealed class ClassEvent extends Equatable {
  const ClassEvent();

  @override
  List<Object> get props => [];
}

class GetAllClasses extends ClassEvent {}

class AddClass extends ClassEvent {
  final GymClass gymclass;

  const AddClass({required this.gymclass});
}

class DeleteClass extends ClassEvent {
  final GymClass gymclass;

  const DeleteClass({required this.gymclass});
}
