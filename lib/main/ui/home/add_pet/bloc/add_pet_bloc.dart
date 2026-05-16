import 'package:demo_app/main/data/database/pet_db_helper.dart';
import 'package:demo_app/main/data/model/pet.dart';
import 'package:demo_app/main/utils/utility_fuctions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'add_pet_event.dart';
import 'add_pet_state.dart';

class AddPetBloc extends Bloc<AddPetEvent, AddPetState> {
  final PetDbHelper _petDbHelper = PetDbHelper.instance;
  final ImagePicker _picker = ImagePicker();
  final Pet? initialPet;

  AddPetBloc({this.initialPet}) : super(const AddPetState()) {
    on<InitPetEvent>(_onInitPet);
    on<PickAvatarEvent>(_onPickAvatar);
    on<NameChangedEvent>(_onNameChanged);
    on<PetTypeSelectedEvent>(_onTypeSelected);
    on<PetBreedSelectedEvent>(_onBreedSelected);
    on<GenderSelectedEvent>(_onGenderSelected);
    on<BirthdayPickedEvent>(_onBirthdayPicked);
    on<WeightChangedEvent>(_onWeightChanged);
    on<ColorChangedEvent>(_onColorChanged);
    on<SavePetEvent>(_onSavePet);
  }

  Future<void> _onPickAvatar(
      PickAvatarEvent event, Emitter<AddPetState> emit) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image == null) return;

    final String? savedPath = await saveImageToLocal(image);
    if (savedPath != null) {
      emit(state.copyWith(avatarPath: savedPath));
    }
  }

  Future<void> _onInitPet(InitPetEvent event, Emitter<AddPetState> emit) async {
    if (event.pet == null) return;
    emit(state.copyWith(
      name: event.pet!.name,
      selectedType: event.pet!.type,
      selectedBreed: event.pet!.breed,
      gender: event.pet!.gender,
      birthday: event.pet!.birthday,
      weight: event.pet!.weight.toString(),
      color: event.pet!.color,
      avatarPath: event.pet!.avatarPath,
    ));
  }

  void _onNameChanged(NameChangedEvent event, Emitter<AddPetState> emit) {
    emit(state.copyWith(name: event.name));
  }

  void _onTypeSelected(PetTypeSelectedEvent event, Emitter<AddPetState> emit) {
    emit(state.copyWith(selectedType: event.type, clearBreed: true));
  }

  void _onBreedSelected(
      PetBreedSelectedEvent event, Emitter<AddPetState> emit) {
    emit(state.copyWith(selectedBreed: event.breed));
  }

  void _onGenderSelected(GenderSelectedEvent event, Emitter<AddPetState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  void _onBirthdayPicked(BirthdayPickedEvent event, Emitter<AddPetState> emit) {
    emit(state.copyWith(birthday: event.birthday));
  }

  void _onWeightChanged(WeightChangedEvent event, Emitter<AddPetState> emit) {
    emit(state.copyWith(weight: event.weight));
  }

  void _onColorChanged(ColorChangedEvent event, Emitter<AddPetState> emit) {
    emit(state.copyWith(color: event.color));
  }

  Future<void> _onSavePet(SavePetEvent event, Emitter<AddPetState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: AddPetStatus.loading));

    try {
      final pet = Pet(
        id: initialPet?.id ?? const Uuid().v4(),
        name: state.name.trim(),
        type: state.selectedType,
        breed: state.selectedBreed,
        gender: state.gender,
        birthday: state.birthday,
        weight: double.tryParse(state.weight),
        color: state.color.trim().isEmpty ? null : state.color.trim(),
        avatarPath: state.avatarPath,
        createdAt: initialPet?.createdAt ?? DateTime.now(),
      );

      await _petDbHelper.savePet(pet);
      print("save thanh cong");
      emit(state.copyWith(status: AddPetStatus.success));
    } catch (_) {
      print("save that bai");
      emit(state.copyWith(status: AddPetStatus.failure));
    }
  }
}
