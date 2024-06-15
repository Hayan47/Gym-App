part of 'upload_bloc.dart';

sealed class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadImagesEvent extends UploadEvent {
  final Uint8List image;
  final String path;

  const UploadImagesEvent({required this.image, required this.path});

  @override
  List<Object> get props => [image];
}
