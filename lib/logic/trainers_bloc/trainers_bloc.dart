import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/data/services/trainer_service.dart';
import 'package:gym/data/services/user_services.dart';

part 'trainers_event.dart';
part 'trainers_state.dart';

class TrainersBloc extends Bloc<TrainersEvent, TrainersState> {
  final trainerService = TrainerService();
  final userServices = UserServices();
  List<Trainer> trainers = [];
  TrainersBloc() : super(TrainersInitial()) {
    on<GetAllTrainers>(
      (event, emit) async {
        try {
          emit(TrainersLoading());
          print(state);
          trainers = await trainerService.getAllTrainers();
          emit(TrainersLoaded(trainers: trainers));
          print(state);
        } catch (e) {
          emit(TrainersError(message: e.toString()));
          print(state);
          print(e);
        }
      },
    );

    on<GetTrainer>(
      (event, emit) async {
        try {
          emit(TrainersLoading());
          print(state);
          final Trainer trainer =
              await userServices.getUserInfo(event.trainerId) as Trainer;
          emit(TrainerLoaded(trainer: trainer));
          print(state);
        } catch (e) {
          emit(TrainersError(message: e.toString()));
          print(state);
        }
      },
    );

    on<RateTrainerEvent>(
      (event, emit) async {
        try {
          emit(TrainersLoading());
          print(state);
          trainerService.rateTrainer(
              event.trainerId, event.userId, event.rating);
          emit(const TrainerRated(message: 'Trainer Rated Successfully'));
          print(state);
        } catch (e) {
          emit(TrainersError(message: e.toString()));
          print(state);
        }
      },
    );
  }
}
