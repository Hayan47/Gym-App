part of 'upload_bloc.dart';

sealed class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object> get props => [];
}

final class UploadInitial extends UploadState {}

class UploadingState extends UploadState {
  final int progress; // Percentage completed (Optional)

  const UploadingState({this.progress = 0});

  @override
  List<Object> get props => [progress];
}

class UploadSuccessState extends UploadState {
  final String message;
  final String imageUrl; // List of uploaded image URLs

  const UploadSuccessState(this.imageUrl, this.message);

  @override
  List<Object> get props => [imageUrl];
}

class UploadFailedState extends UploadState {
  final String message;

  const UploadFailedState(this.message);

  @override
  List<Object> get props => [message];
}
