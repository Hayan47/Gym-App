import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/jobs_bloc/jobs_bloc.dart';
import 'package:gym/presentation/widgets/job_card.dart';
import 'package:gym/presentation/widgets/shimmer_jobs.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<JobsBloc>().add(GetAllJobs());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Availavle Jobs',
          style: GoogleFonts.nunito(
            color: MyColors.myOrange2,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<JobsBloc, JobsState>(
        builder: (context, state) {
          if (state is JobsLoaded) {
            return ListView.builder(
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                return JobCard(job: state.jobs[index]);
              },
            );
          } else {
            return const JobsLoadingWidget();
          }
        },
      ),
    );
  }
}
