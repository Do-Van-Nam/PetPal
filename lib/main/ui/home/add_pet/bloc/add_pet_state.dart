import 'package:demo_app/main/data/model/pet.dart';
import 'package:equatable/equatable.dart';

enum AddPetStatus { initial, loading, success, failure }

class AddPetState extends Equatable {
  final AddPetStatus status;

  // Form fields
  final String? avatarPath;
  final String name;
  final PetType selectedType;
  final PetBreed? selectedBreed;
  final PetGender gender;
  final DateTime? birthday;
  final String weight;
  final String color;

  // Helper: danh sách giống theo loài đã chọn
  List<PetBreed> get availableBreeds =>
      PetBreed.getBreedsByType(selectedType);

  // Helper: form hợp lệ khi có tên
  bool get isValid => name.trim().isNotEmpty;

  const AddPetState({
    this.status = AddPetStatus.initial,
    this.avatarPath,
    this.name = '',
    this.selectedType = PetType.dog,
    this.selectedBreed,
    this.gender = PetGender.unknown,
    this.birthday,
    this.weight = '',
    this.color = '',
  });

  AddPetState copyWith({
    AddPetStatus? status,
    String? avatarPath,
    String? name,
    PetType? selectedType,
    PetBreed? selectedBreed,
    bool clearBreed = false,
    PetGender? gender,
    DateTime? birthday,
    String? weight,
    String? color,
  }) {
    return AddPetState(
      status: status ?? this.status,
      avatarPath: avatarPath ?? this.avatarPath,
      name: name ?? this.name,
      selectedType: selectedType ?? this.selectedType,
      // Khi đổi loài, xóa giống cũ
      selectedBreed: clearBreed ? null : (selectedBreed ?? this.selectedBreed),
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      weight: weight ?? this.weight,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [
        status,
        avatarPath,
        name,
        selectedType,
        selectedBreed,
        gender,
        birthday,
        weight,
        color,
      ];
}
