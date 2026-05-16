import 'package:demo_app/main/data/database/activity_db_helper.dart';
import 'package:demo_app/main/data/database/pet_db_helper.dart';
import 'package:demo_app/main/data/database/photo_db_helper.dart';
import 'package:demo_app/main/data/model/activity.dart';
import 'package:demo_app/main/data/model/pet.dart';
import 'package:demo_app/main/data/model/photo.dart';
import 'package:demo_app/main/utils/utility_fuctions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PetDbHelper _petDbHelper = PetDbHelper.instance;
  final PhotoDbHelper _photoDbHelper = PhotoDbHelper.instance;
  final ActivityDbHelper _activityDbHelper = ActivityDbHelper.instance;

  final ImagePicker _picker = ImagePicker();

  HomeBloc() : super(const HomeState()) {
    on<HomeInitialized>(_onHomeInitialized);
    on<SelectPetEvent>(_onSelectPet);
    on<AddPetEvent>(_onAddPet);
    on<DeletePetEvent>(_onDeletePet);
    on<CameraTapEvent>(_onCameraTap);
    on<LibraryTapEvent>(_onLibraryTap);
    on<SavePhotoEvent>(_onSavePhoto);
    on<ClearPickedPhotoEvent>(_onClearPickedPhoto);
    on<ToggleMemoriesViewEvent>(_onToggleMemoriesView);
  }

  // ─── Load dữ liệu lần đầu ────────────────────────────────────────────────────

  Future<void> _onHomeInitialized(
      HomeInitialized event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final List<Pet> pets = await _petDbHelper.loadAllPets();

    // Mặc định chọn pet đầu tiên nếu có
    final Pet? selectedPet = pets.isNotEmpty ? pets.first : null;

    // Load ảnh và activity của pet đầu tiên
    List<Photo> photos = [];
    List<Activity> activities = [];
    if (selectedPet != null) {
      photos = await _photoDbHelper.loadPhotosByPet(selectedPet.id);
      activities = await _activityDbHelper.loadActivitiesByPet(selectedPet.id);
    }

    emit(state.copyWith(
      status: HomeStatus.success,
      pets: pets,
      selectedPet: selectedPet,
      photos: photos,
      activities: activities,
    ));
  }

  // ─── Chọn pet ─────────────────────────────────────────────────────────────────

  Future<void> _onSelectPet(
      SelectPetEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    // Load ảnh và activity của pet được chọn
    final List<Photo> photos =
        await _photoDbHelper.loadPhotosByPet(event.pet.id);
    final List<Activity> activities =
        await _activityDbHelper.loadActivitiesByPet(event.pet.id);

    emit(state.copyWith(
      status: HomeStatus.success,
      selectedPet: event.pet,
      photos: photos,
      activities: activities,
    ));
  }

  // ─── Thêm pet mới ─────────────────────────────────────────────────────────────

  Future<void> _onAddPet(AddPetEvent event, Emitter<HomeState> emit) async {
    await _petDbHelper.savePet(event.pet);

    final updatedPets = List<Pet>.from(state.pets)..add(event.pet);

    emit(state.copyWith(
      pets: updatedPets,
      selectedPet: event.pet, // Tự động chọn pet vừa thêm
      photos: [],
      activities: [],
    ));
  }

  // ─── Xóa pet ──────────────────────────────────────────────────────────────────

  Future<void> _onDeletePet(
      DeletePetEvent event, Emitter<HomeState> emit) async {
    await _petDbHelper.deletePet(event.petId);
    await _photoDbHelper.deleteAllPhotosByPet(event.petId);
    await _activityDbHelper.deleteActivitiesByPet(event.petId);

    final updatedPets =
        state.pets.where((p) => p.id != event.petId).toList();

    // Chọn pet đầu tiên còn lại sau khi xóa
    final Pet? newSelected = updatedPets.isNotEmpty ? updatedPets.first : null;

    List<Photo> photos = [];
    List<Activity> activities = [];
    if (newSelected != null) {
      photos = await _photoDbHelper.loadPhotosByPet(newSelected.id);
      activities = await _activityDbHelper.loadActivitiesByPet(newSelected.id);
    }

    emit(state.copyWith(
      pets: updatedPets,
      selectedPet: newSelected,
      photos: photos,
      activities: activities,
    ));
  }

  // ─── Camera ───────────────────────────────────────────────────────────────────

  Future<void> _onCameraTap(
      CameraTapEvent event, Emitter<HomeState> emit) async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (image != null) {
      emit(state.copyWith(pickedPhoto: image));
    }
  }

  // ─── Library ──────────────────────────────────────────────────────────────────

  Future<void> _onLibraryTap(
      LibraryTapEvent event, Emitter<HomeState> emit) async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (image != null) {
      emit(state.copyWith(pickedPhoto: image));
    }
  }

  // ─── Save Photo ───────────────────────────────────────────────────────────────

  Future<void> _onSavePhoto(
      SavePhotoEvent event, Emitter<HomeState> emit) async {
    try {
      // Lưu ảnh vào thư mục local của app
      final String? savedPath =
          await saveImageToLocal(state.pickedPhoto);
      if (savedPath == null) return;

      final photo = Photo(
        id: const Uuid().v4(),
        petId: event.petId,
        caption: event.caption,
        path: savedPath,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await PhotoDbHelper.instance.savePhoto(photo);

      // Reload photos nếu pet đang được chọn là pet của ảnh vừa lưu
      List<Photo> updatedPhotos = state.photos;
      if (state.selectedPet?.id == event.petId) {
        updatedPhotos =
            await PhotoDbHelper.instance.loadPhotosByPet(event.petId);
      }

      emit(state.copyWith(
        photos: updatedPhotos,
        clearPickedPhoto: true, // xóa pickedPhoto sau khi lưu xong
      ));
    } catch (_) {
      emit(state.copyWith(clearPickedPhoto: true));
    }
  }

  // ─── Clear Picked Photo ───────────────────────────────────────────────────────

  void _onClearPickedPhoto(
      ClearPickedPhotoEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(clearPickedPhoto: true));
  }

  void _onToggleMemoriesView(
      ToggleMemoriesViewEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(isGridView: event.isGridView));
  }
}
