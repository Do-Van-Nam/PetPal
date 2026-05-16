import 'package:demo_app/main/data/database/photo_db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'photo_detail_event.dart';
import 'photo_detail_state.dart';

class PhotoDetailBloc extends Bloc<PhotoDetailEvent, PhotoDetailState> {
  final PhotoDbHelper _photoDbHelper = PhotoDbHelper.instance;

  PhotoDetailBloc() : super(const PhotoDetailState()) {
    on<LoadPhotoEvent>(_onLoadPhoto);
    on<ToggleEditCaptionEvent>(_onToggleEditCaption);
    on<UpdateCaptionTextEvent>(_onUpdateCaptionText);
    on<SavePhotoCaptionEvent>(_onSavePhotoCaption);
    on<DeletePhotoEvent>(_onDeletePhoto);
  }

  Future<void> _onLoadPhoto(
      LoadPhotoEvent event, Emitter<PhotoDetailState> emit) async {
    emit(state.copyWith(status: PhotoDetailStatus.loading));
    try {
      final photo = await _photoDbHelper.getPhotoById(event.photoId);
      emit(state.copyWith(
        status: PhotoDetailStatus.success,
        photo: photo,
        editedCaption: photo.caption ?? '',
      ));
    } catch (e) {
      emit(state.copyWith(status: PhotoDetailStatus.failure));
    }
  }

  void _onToggleEditCaption(
      ToggleEditCaptionEvent event, Emitter<PhotoDetailState> emit) {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  void _onUpdateCaptionText(
      UpdateCaptionTextEvent event, Emitter<PhotoDetailState> emit) {
    emit(state.copyWith(editedCaption: event.caption));
  }

  Future<void> _onSavePhotoCaption(
      SavePhotoCaptionEvent event, Emitter<PhotoDetailState> emit) async {
    if (state.photo == null) return;
    try {
      final updatedPhoto = state.photo!.copyWith(caption: state.editedCaption);
      await _photoDbHelper.savePhoto(updatedPhoto);
      emit(state.copyWith(
        photo: updatedPhoto,
        isEditing: false,
        didEdit: true,
      ));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> _onDeletePhoto(
      DeletePhotoEvent event, Emitter<PhotoDetailState> emit) async {
    if (state.photo == null) return;
    try {
      await _photoDbHelper.deletePhoto(state.photo!.id!);
    } catch (e) {
      // Handle error
    }
  }
}
