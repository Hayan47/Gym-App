import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/class_bloc/class_bloc.dart';
import 'package:gym/presentation/widgets/class_card.dart';
import 'package:gym/presentation/widgets/shimmer_classes.dart';
import 'package:lottie/lottie.dart';

class EnrolledClassesScreen extends StatelessWidget {
  final String participantId;
  const EnrolledClassesScreen({super.key, required this.participantId});

  @override
  Widget build(BuildContext context) {
    context
        .read<ClassBloc>()
        .add(GetParticipantClasses(participantId: participantId));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Enrolled Classes',
          style: GoogleFonts.nunito(
            color: MyColors.myOrange2,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ClassBloc, ClassState>(
        builder: (context, state) {
          if (state is ClassLoaded) {
            if (state.gymclasses.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.4,
                      child: Image.asset(
                        'assets/lottie/gym_class.jpg',
                      ),
                    ),
                  ),
                  Text(
                    'Join classes to get fit!',
                    style: GoogleFonts.nunito(
                      color: MyColors.myOrange2,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: state.gymclasses.length,
                itemBuilder: (context, index) {
                  return ClassCard(gymClass: state.gymclasses[index]);
                },
              );
            }
          } else {
            return const ClassesLoading();
          }
        },
      ),
    );
  }
}
