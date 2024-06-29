part of 'jobs_bloc.dart';

sealed class JobsEvent extends Equatable {
  const JobsEvent();

  @override
  List<Object> get props => [];
}

class GetAllJobs extends JobsEvent {}

class AddJob extends JobsEvent {
  final Job job;

  const AddJob({required this.job});
}
