import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gym/data/models/job_model.dart';
import 'package:gym/data/services/job_service.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  List<Job> allJobs = [];
  final jobService = JobService();
  JobsBloc() : super(JobsInitial()) {
    on<GetAllJobs>(
      (event, emit) async {
        try {
          emit(JobsLoading());
          print(state);
          allJobs = await jobService.getAllJobs();
          emit(JobsLoaded(jobs: allJobs));
          print(state);
        } catch (e) {
          emit(JobsError(message: e.toString()));
          print(state);
        }
      },
    );

    on<AddJob>(
      (event, emit) async {
        try {
          emit(JobsLoading());
          await jobService.addJob(event.job);
          emit(const JobAdded(message: 'Job Added Successfully'));
          // add(GetAllCarsEvent());
          print(state);
        } catch (e) {
          emit(JobsError(message: e.toString()));
          print(state);
        }
      },
    );
  }
}
