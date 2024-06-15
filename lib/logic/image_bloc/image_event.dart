part of 'image_bloc.dart';

sealed class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class AddImageEvent extends ImageEvent {
  const AddImageEvent();
}

class NoImageSelectedEvent extends ImageEvent {}
