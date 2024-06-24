part of 'trainers_bloc.dart';

sealed class TrainersEvent extends Equatable {
  const TrainersEvent();

  @override
  List<Object> get props => [];
}

class GetAllTrainers extends TrainersEvent {}

class GetTrainer extends TrainersEvent {
  final String trainerId;

  const GetTrainer({required this.trainerId});
}
