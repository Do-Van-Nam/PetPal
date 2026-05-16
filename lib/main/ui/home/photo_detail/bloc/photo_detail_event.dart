import 'package:equatable/equatable.dart';

abstract class PhotoDetailEvent extends Equatable {
  const PhotoDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadPhotoEvent extends PhotoDetailEvent {
  final String photoId;
  const LoadPhotoEvent(this.photoId);

  @override
  List<Object?> get props => [photoId];
}

class ToggleEditCaptionEvent extends PhotoDetailEvent {}

class UpdateCaptionTextEvent extends PhotoDetailEvent {
  final String caption;
  const UpdateCaptionTextEvent(this.caption);

  @override
  List<Object?> get props => [caption];
}

class SavePhotoCaptionEvent extends PhotoDetailEvent {}

class DeletePhotoEvent extends PhotoDetailEvent {}
