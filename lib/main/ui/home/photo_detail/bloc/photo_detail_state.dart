import 'package:demo_app/main/data/model/photo.dart';
import 'package:equatable/equatable.dart';

enum PhotoDetailStatus { loading, success, failure }

class PhotoDetailState extends Equatable {
  final PhotoDetailStatus status;
  final Photo? photo;
  final bool isEditing;
  final bool didEdit;
  final String editedCaption;

  const PhotoDetailState({
    this.status = PhotoDetailStatus.loading,
    this.photo,
    this.isEditing = false,
    this.didEdit = false,
    this.editedCaption = '',
  });

  PhotoDetailState copyWith({
    PhotoDetailStatus? status,
    Photo? photo,
    bool? isEditing,
    String? editedCaption,
    bool? didEdit,
  }) {
    return PhotoDetailState(
      status: status ?? this.status,
      photo: photo ?? this.photo,
      isEditing: isEditing ?? this.isEditing,
      editedCaption: editedCaption ?? this.editedCaption,
      didEdit: didEdit ?? this.didEdit,
    );
  }

  @override
  List<Object?> get props => [status, photo, isEditing, editedCaption, didEdit];
}
