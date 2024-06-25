part of 'trainers_bloc.dart';

sealed class TrainersState extends Equatable {
  const TrainersState();

  @override
  List<Object> get props => [];
}

final class TrainersInitial extends TrainersState {}

final class TrainersLoading extends TrainersState {}

final class TrainersLoaded extends TrainersState {
  final List<Trainer> trainers;

  const TrainersLoaded({required this.trainers});

  @override
  List<Object> get props => [trainers];
}

final class TrainerLoaded extends TrainersState {
  final Trainer trainer;

  const TrainerLoaded({required this.trainer});

  @override
  List<Object> get props => [trainer];
}

final class TrainersError extends TrainersState {
  final String message;

  const TrainersError({required this.message});

  @override
  List<Object> get props => [message];
}

final class TrainerRated extends TrainersState {
  final String message;

  const TrainerRated({required this.message});

  @override
  List<Object> get props => [message];
}
