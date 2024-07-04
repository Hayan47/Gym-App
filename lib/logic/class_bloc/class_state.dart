part of 'class_bloc.dart';

sealed class ClassState extends Equatable {
  const ClassState();

  @override
  List<Object> get props => [];
}

final class ClassInitial extends ClassState {}

final class ClassLoading extends ClassState {}

final class ClassLoaded extends ClassState {
  final List<GymClass> gymclasses;

  const ClassLoaded({required this.gymclasses});

  @override
  List<Object> get props => [gymclasses];
}

final class ClassError extends ClassState {
  final String message;

  const ClassError({required this.message});

  @override
  List<Object> get props => [message];
}

final class ClassAdded extends ClassState {
  final String message;

  const ClassAdded({required this.message});

  @override
  List<Object> get props => [message];
}

final class ClassDeleted extends ClassState {
  final String message;

  const ClassDeleted({required this.message});

  @override
  List<Object> get props => [message];
}

final class ClassJoined extends ClassState {
  final String message;

  const ClassJoined({required this.message});

  @override
  List<Object> get props => [message];
}

final class ClassUpdated extends ClassState {
  final String message;

  const ClassUpdated({required this.message});
}
