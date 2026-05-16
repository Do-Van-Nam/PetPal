import 'package:demo_app/main/data/model/pet.dart';
import 'package:equatable/equatable.dart';

abstract class AddPetEvent extends Equatable {
  const AddPetEvent();
  @override
  List<Object?> get props => [];
}

class PickAvatarEvent extends AddPetEvent {}

class InitPetEvent extends AddPetEvent {
  final Pet? pet;
  const InitPetEvent(this.pet);
  @override
  List<Object?> get props => [pet];
}

class NameChangedEvent extends AddPetEvent {
  final String name;
  const NameChangedEvent(this.name);
  @override
  List<Object?> get props => [name];
}

class PetTypeSelectedEvent extends AddPetEvent {
  final PetType type;
  const PetTypeSelectedEvent(this.type);
  @override
  List<Object?> get props => [type];
}

class PetBreedSelectedEvent extends AddPetEvent {
  final PetBreed breed;
  const PetBreedSelectedEvent(this.breed);
  @override
  List<Object?> get props => [breed];
}

class GenderSelectedEvent extends AddPetEvent {
  final PetGender gender;
  const GenderSelectedEvent(this.gender);
  @override
  List<Object?> get props => [gender];
}

class BirthdayPickedEvent extends AddPetEvent {
  final DateTime birthday;
  const BirthdayPickedEvent(this.birthday);
  @override
  List<Object?> get props => [birthday];
}

class WeightChangedEvent extends AddPetEvent {
  final String weight;
  const WeightChangedEvent(this.weight);
  @override
  List<Object?> get props => [weight];
}

class ColorChangedEvent extends AddPetEvent {
  final String color;
  const ColorChangedEvent(this.color);
  @override
  List<Object?> get props => [color];
}

class SavePetEvent extends AddPetEvent {}
