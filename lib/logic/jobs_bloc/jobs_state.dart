part of 'jobs_bloc.dart';

sealed class JobsState extends Equatable {
  const JobsState();

  @override
  List<Object> get props => [];
}

final class JobsInitial extends JobsState {}

final class JobsLoading extends JobsState {}

final class JobsLoaded extends JobsState {
  final List<Job> jobs;

  const JobsLoaded({required this.jobs});

  @override
  List<Object> get props => [jobs];
}

final class JobsError extends JobsState {
  final String message;

  const JobsError({required this.message});

  @override
  List<Object> get props => [message];
}

final class JobAdded extends JobsState {
  final String message;

  const JobAdded({required this.message});

  @override
  List<Object> get props => [message];
}
