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

class RateTrainerEvent extends TrainersEvent {
  final String trainerId;
  final String userId;
  final double rating;

  const RateTrainerEvent(
      {required this.trainerId, required this.userId, required this.rating});
}
