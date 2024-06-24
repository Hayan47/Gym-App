import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/class_model.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/auth_cubit/auth_cubit.dart';
import 'package:gym/logic/class_bloc/class_bloc.dart';
import 'package:gym/logic/trainers_bloc/trainers_bloc.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/widgets/shimmer_trainers.dart';
import 'package:gym/presentation/widgets/trainer_card.dart';
import 'package:lottie/lottie.dart';

class ClassDetailsScreen extends StatelessWidget {
  final GymClass gymClass;
  const ClassDetailsScreen({super.key, required this.gymClass});

  @override
  Widget build(BuildContext context) {
    context.read<TrainersBloc>().add(GetTrainer(trainerId: gymClass.trainerId));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          gymClass.name,
          style: GoogleFonts.nunito(
            color: MyColors.myOrange2,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: MyColors.myOrange2.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                textAlign: TextAlign.center,
                gymClass.description,
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.myOrange2.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    textAlign: TextAlign.center,
                    gymClass.difficulty,
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.myOrange2.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    textAlign: TextAlign.center,
                    gymClass.duration,
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.myOrange2.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    textAlign: TextAlign.center,
                    gymClass.location,
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: MyColors.myOrange2.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  textAlign: TextAlign.center,
                  gymClass.schedule,
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Divider(
              color: MyColors.myOrange2.withOpacity(0.4),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: MyColors.myOrange2.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                "Equipment Neddded: ",
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ...List.generate(
              gymClass.equipmentNeeded.length,
              (index) {
                return Text(
                  "${index + 1}- ${gymClass.equipmentNeeded[index]}",
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: MyColors.myOrange2.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                "Special Instructions: ",
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            ...List.generate(
              gymClass.specialInstructions.length,
              (index) {
                return Text(
                  "${index + 1}- ${gymClass.specialInstructions[index]}",
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: MyColors.myOrange2.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                "Instructor: ",
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            BlocBuilder<TrainersBloc, TrainersState>(
              builder: (context, state) {
                if (state is TrainerLoaded) {
                  return TrainerCard(trainer: state.trainer);
                } else {
                  return const SizedBox(
                      height: 260, child: TrainerLoading(itemCount: 1));
                  // return Container();
                }
              },
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.myOrange2.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Capacity: ${gymClass.capacity}",
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.myOrange2.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Remaining: ${gymClass.capacity - gymClass.memberIds.length}",
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, userstate) {
                  if (userstate is UserLoaded) {
                    if (userstate.userInfo is Participant) {
                      return BlocConsumer<ClassBloc, ClassState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is ClassLoading) {
                            return SizedBox(
                              width: 70,
                              height: 40,
                              child: Lottie.asset(
                                  'assets/lottie/SplashyLoader.json'),
                            );
                          } else {
                            if (gymClass.memberIds
                                .contains(userstate.userInfo.userid)) {
                              return Container(
                                width: 160,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: MyColors.myOrange2.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Text(
                                    'Joined',
                                    style: GoogleFonts.nunito(
                                      color: MyColors.mywhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return TextButton(
                                onPressed: () async {
                                  if (gymClass.capacity -
                                          gymClass.memberIds.length ==
                                      0) {
                                    return;
                                  }
                                  context.read<ClassBloc>().add(
                                        JoinClass(
                                            userId: userstate.userInfo.userid,
                                            classId: gymClass.classid!),
                                      );
                                },
                                style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    fixedSize: WidgetStateProperty.all(
                                        const Size(160, 40)),
                                    backgroundColor: WidgetStateProperty.all(
                                        MyColors.myOrange2)),
                                child: Text(
                                  'Join Class',
                                  style: GoogleFonts.nunito(
                                    color: MyColors.mywhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
