import 'package:demo_app/main/data/model/activity.dart';
import 'package:demo_app/main/data/model/pet.dart';
import 'package:demo_app/main/data/model/photo.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Pet> pets;
  final Pet? selectedPet;
  final List<Photo> photos;
  final List<Activity> activities;

  /// Ảnh vừa chụp / chọn từ thư viện, chờ user điền thông tin rồi lưu
  final XFile? pickedPhoto;
  
  final bool isGridView;

  const HomeState({
    this.status = HomeStatus.initial,
    this.pets = const [],
    this.selectedPet,
    this.photos = const [],
    this.activities = const [],
    this.pickedPhoto,
    this.isGridView = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<Pet>? pets,
    Pet? selectedPet,
    List<Photo>? photos,
    List<Activity>? activities,
    XFile? pickedPhoto,
    bool clearPickedPhoto = false,
    bool? isGridView,
  }) {
    return HomeState(
      status: status ?? this.status,
      pets: pets ?? this.pets,
      selectedPet: selectedPet ?? this.selectedPet,
      photos: photos ?? this.photos,
      activities: activities ?? this.activities,
      pickedPhoto: clearPickedPhoto ? null : (pickedPhoto ?? this.pickedPhoto),
      isGridView: isGridView ?? this.isGridView,
    );
  }

  @override
  List<Object?> get props =>
      [status, pets, selectedPet, photos, activities, pickedPhoto?.path, isGridView];
}
