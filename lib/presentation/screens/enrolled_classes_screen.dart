import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/class_bloc/class_bloc.dart';
import 'package:gym/presentation/widgets/class_card.dart';
import 'package:gym/presentation/widgets/shimmer_classes.dart';

class EnrolledClassesScreen extends StatelessWidget {
  final String participantId;
  const EnrolledClassesScreen({super.key, required this.participantId});

  @override
  Widget build(BuildContext context) {
    context
        .read<ClassBloc>()
        .add(GetParticipantClasses(participantId: participantId));
    return Scaffold(
      appBar: AppBar(
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
            return ListView.builder(
              itemCount: state.gymclasses.length,
              itemBuilder: (context, index) {
                return ClassCard(gymClass: state.gymclasses[index]);
              },
            );
          } else {
            return const ClassesLoading();
          }
        },
      ),
    );
  }
}
