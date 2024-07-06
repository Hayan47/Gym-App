import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/class_model.dart';
import 'package:gym/data/models/membership_model.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/class_bloc/class_bloc.dart';
import 'package:gym/logic/membership_bloc/membership_bloc.dart';
import 'package:gym/logic/trainers_bloc/trainers_bloc.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/widgets/alert_dialog.dart';
import 'package:gym/presentation/widgets/shimmer_card.dart';
import 'package:gym/presentation/widgets/toast.dart';
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
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: MyColors.myOrange2.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 25),
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
            indent: 25,
            endIndent: 25,
            color: MyColors.myOrange2.withOpacity(0.4),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: MyColors.myOrange2.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 25),
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "${index + 1}- ${gymClass.equipmentNeeded[index]}",
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 17,
                  ),
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
            margin: const EdgeInsets.symmetric(horizontal: 25),
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "${index + 1}- ${gymClass.specialInstructions[index]}",
                  style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 17,
                  ),
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
            margin: const EdgeInsets.symmetric(horizontal: 25),
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
          BlocConsumer<TrainersBloc, TrainersState>(
            listener: (context, state) {
              if (state is! TrainerLoaded && state is! TrainersLoading) {
                context
                    .read<TrainersBloc>()
                    .add(GetTrainer(trainerId: gymClass.trainerId));
              }
            },
            builder: (context, state) {
              if (state is TrainerLoaded) {
                return TrainerCard(trainer: state.trainer);
              } else {
                return const SizedBox(height: 240, child: CardLoading());
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
                      listener: (context, state) {
                        if (state is ClassJoined) {
                          showToastMessage(
                            context,
                            state.message,
                            const Icon(
                              Icons.done,
                              color: Colors.green,
                              size: 20,
                            ),
                          );
                        } else if (state is ClassError) {
                          showToastMessage(
                            context,
                            state.message,
                            const Icon(
                              Icons.error,
                              color: MyColors.myred2,
                              size: 20,
                            ),
                          );
                        }
                      },
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
                            context.read<MembershipBloc>().add(GetMemberships(
                                userid: userstate.userInfo.userid));
                            return BlocBuilder<MembershipBloc, MembershipState>(
                              builder: (context, state) {
                                if (state is MembershipLoaded) {
                                  return TextButton(
                                    onPressed: () async {
                                      bool hasActive = false;
                                      //!loop through memberships and check
                                      for (Membership membership
                                          in state.memberships) {
                                        if (membership.state == "active") {
                                          hasActive = true;
                                          break;
                                        }
                                        //!no active membership
                                        if (!hasActive) {
                                          showToastMessage(
                                            context,
                                            "You have no active membership",
                                            const Icon(
                                              Icons.error,
                                              color: MyColors.myred2,
                                              size: 20,
                                            ),
                                          );
                                          return;
                                        }
                                      }
                                      //!found active membership
                                      //!check for remaining places
                                      if (gymClass.capacity -
                                              gymClass.memberIds.length ==
                                          0) {
                                        return;
                                      }
                                      context.read<ClassBloc>().add(
                                            JoinClass(
                                                userId:
                                                    userstate.userInfo.userid,
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
                                        backgroundColor:
                                            WidgetStateProperty.all(
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
                                } else {
                                  return SizedBox(
                                    width: 70,
                                    height: 40,
                                    child: Lottie.asset(
                                        'assets/lottie/SplashyLoader.json'),
                                  );
                                }
                              },
                            );
                          }
                        }
                      },
                    );
                  } else if (userstate.userInfo is Trainer) {
                    if (userstate.userInfo.userid == gymClass.trainerId) {
                      return BlocConsumer<ClassBloc, ClassState>(
                        listener: (context, state) {
                          if (state is ClassDeleted) {
                            showToastMessage(
                              context,
                              state.message,
                              const Icon(
                                Icons.done,
                                color: Colors.green,
                                size: 20,
                              ),
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                            context.read<ClassBloc>().add(GetAllClasses());
                          } else if (state is ClassError) {
                            showToastMessage(
                              context,
                              state.message,
                              const Icon(
                                Icons.error,
                                color: MyColors.myred2,
                                size: 20,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ClassLoading) {
                            return SizedBox(
                              width: 70,
                              height: 40,
                              child: Lottie.asset(
                                  'assets/lottie/SplashyLoader.json'),
                            );
                          } else {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    gymClass.state == "pending"
                                        ? const Icon(
                                            Icons.circle,
                                            color: MyColors.myOrange3,
                                            size: 15,
                                          )
                                        : gymClass.state == "approved"
                                            ? const Icon(
                                                Icons.circle,
                                                color: Colors.green,
                                                size: 15,
                                              )
                                            : const Icon(
                                                Icons.circle,
                                                color: Colors.red,
                                                size: 15,
                                              ),
                                    const SizedBox(width: 3),
                                    Text(
                                      gymClass.state,
                                      style: GoogleFonts.nunito(
                                        color: MyColors.myGrey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return MyAlertDialog(
                                            onPressed: () {
                                              context.read<ClassBloc>().add(
                                                    DeleteClass(
                                                        gymclass: gymClass),
                                                  );
                                            },
                                            text:
                                                'Are you sure you want to delete class?');
                                      },
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
                                    'Delete Class',
                                    style: GoogleFonts.nunito(
                                      color: MyColors.mywhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    if (gymClass.state == "pending") {
                      return BlocListener<ClassBloc, ClassState>(
                        listener: (context, state) {
                          if (state is ClassUpdated) {
                            showToastMessage(
                              context,
                              state.message,
                              const Icon(
                                Icons.done,
                                color: Colors.green,
                                size: 20,
                              ),
                            );
                            Navigator.pop(context);
                            context.read<ClassBloc>().add(GetPendingClasses());
                          } else if (state is ClassError) {
                            showToastMessage(
                              context,
                              state.message,
                              const Icon(
                                Icons.error,
                                color: MyColors.myred2,
                                size: 20,
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.read<ClassBloc>().add(
                                        UpdateGymClassState(
                                            classid: gymClass.classid!,
                                            newState: "approved"),
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
                                  'Accept',
                                  style: GoogleFonts.nunito(
                                    color: MyColors.mywhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.read<ClassBloc>().add(
                                        UpdateGymClassState(
                                            classid: gymClass.classid!,
                                            newState: "rejected"),
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
                                        MyColors.myGrey)),
                                child: Text(
                                  'Reject',
                                  style: GoogleFonts.nunito(
                                    color: MyColors.mywhite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
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
    );
  }
}
