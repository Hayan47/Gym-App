import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/logic/trainers_bloc/trainers_bloc.dart';
import 'package:gym/presentation/widgets/shimmer_trainers.dart';
import 'package:gym/presentation/widgets/trainer_card.dart';

class TrainersScreen extends StatelessWidget {
  const TrainersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TrainersBloc>().add(GetAllTrainers());
    return Scaffold(
      body: BlocConsumer<TrainersBloc, TrainersState>(
        listener: (context, state) {
          if (state is! TrainersLoaded && state is! TrainersLoading) {
            context.read<TrainersBloc>().add(GetAllTrainers());
          }
        },
        builder: (context, state) {
          if (state is TrainersLoaded) {
            return ListView.builder(
              itemCount: state.trainers.length,
              itemBuilder: (context, index) {
                return TrainerCard(trainer: state.trainers[index]);
              },
            );
          } else {
            return const TrainerLoading();
          }
        },
      ),
    );
  }
}
