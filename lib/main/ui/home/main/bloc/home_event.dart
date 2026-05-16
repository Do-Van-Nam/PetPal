import 'package:demo_app/main/data/model/pet.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeInitialized extends HomeEvent {}

/// Chọn pet từ danh sách
class SelectPetEvent extends HomeEvent {
  final Pet pet;
  const SelectPetEvent(this.pet);

  @override
  List<Object?> get props => [pet];
}

/// Thêm pet mới
class AddPetEvent extends HomeEvent {
  final Pet pet;
  const AddPetEvent(this.pet);

  @override
  List<Object?> get props => [pet];
}

/// Xóa pet
class DeletePetEvent extends HomeEvent {
  final String petId;
  const DeletePetEvent(this.petId);

  @override
  List<Object?> get props => [petId];
}

/// Chụp ảnh từ camera
class CameraTapEvent extends HomeEvent {}

/// Chọn ảnh từ thư viện
class LibraryTapEvent extends HomeEvent {}

/// Lưu photo vào memories sau khi user điền thông tin
class SavePhotoEvent extends HomeEvent {
  final String petId;
  final String caption;
  final String imagePath; // đường dẫn local đã lưu
  const SavePhotoEvent({
    required this.petId,
    required this.caption,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [petId, caption, imagePath];
}

/// Xóa pickedPhoto khỏi state (đóng bottomsheet mà không lưu)
class ClearPickedPhotoEvent extends HomeEvent {}

class ToggleMemoriesViewEvent extends HomeEvent {
  final bool isGridView;
  const ToggleMemoriesViewEvent(this.isGridView);
  
  @override
  List<Object?> get props => [isGridView];
}
