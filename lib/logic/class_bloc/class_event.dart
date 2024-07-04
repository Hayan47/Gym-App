part of 'class_bloc.dart';

sealed class ClassEvent extends Equatable {
  const ClassEvent();

  @override
  List<Object> get props => [];
}

class GetAllClasses extends ClassEvent {}

class GetPendingClasses extends ClassEvent {}

class AddClass extends ClassEvent {
  final GymClass gymclass;

  const AddClass({required this.gymclass});
}

class DeleteClass extends ClassEvent {
  final GymClass gymclass;

  const DeleteClass({required this.gymclass});
}

class GetTrainerClasses extends ClassEvent {
  final String trainerId;

  const GetTrainerClasses({required this.trainerId});
}

class GetParticipantClasses extends ClassEvent {
  final String participantId;

  const GetParticipantClasses({required this.participantId});
}

class JoinClass extends ClassEvent {
  final String userId;
  final String classId;

  const JoinClass({required this.userId, required this.classId});
}

class UpdateGymClassState extends ClassEvent {
  final String classid;
  final String newState;

  const UpdateGymClassState({required this.classid, required this.newState});
}
