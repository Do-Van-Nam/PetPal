enum PetType { dog, cat, bird, other }

enum PetGender { male, female, unknown }

class Pet {
  final String id;
  final String name;
  final PetType type;
  final String? breed;
  final PetGender gender;
  final double? weight;
  final DateTime? birthday;
  final String? color;
  final String? avatarUrl;
  final String ownerId;
  final bool vaccinated;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Pet({
    required this.id,
    required this.name,
    required this.type,
    this.breed,
    this.gender = PetGender.unknown,
    this.weight,
    this.birthday,
    this.color,
    this.avatarUrl,
    required this.ownerId,
    this.vaccinated = false,
    this.createdAt,
    this.updatedAt,
  });

  // ================= JSON =================

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      type: _parseType(json['type']),
      breed: json['breed'],
      gender: _parseGender(json['gender']),
      weight: _parseDouble(json['weight']),
      birthday: _parseDate(json['birthday']),
      color: json['color'],
      avatarUrl: json['avatar_url'],
      ownerId: json['owner_id']?.toString() ?? '',
      vaccinated: json['vaccinated'] == true || json['vaccinated'] == 1,
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'breed': breed,
      'gender': gender.name,
      'weight': weight,
      'birthday': birthday?.toIso8601String(),
      'color': color,
      'avatar_url': avatarUrl,
      'owner_id': ownerId,
      'vaccinated': vaccinated,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // ================= HELPERS =================

  static PetType _parseType(dynamic value) {
    switch (value?.toString().toLowerCase()) {
      case 'dog':
        return PetType.dog;
      case 'cat':
        return PetType.cat;
      case 'bird':
        return PetType.bird;
      default:
        return PetType.other;
    }
  }

  static PetGender _parseGender(dynamic value) {
    switch (value?.toString().toLowerCase()) {
      case 'male':
        return PetGender.male;
      case 'female':
        return PetGender.female;
      default:
        return PetGender.unknown;
    }
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  // ================= COPY =================

  Pet copyWith({
    String? name,
    PetType? type,
    String? breed,
    PetGender? gender,
    double? weight,
    DateTime? birthday,
    String? color,
    String? avatarUrl,
    bool? vaccinated,
  }) {
    return Pet(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      breed: breed ?? this.breed,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      birthday: birthday ?? this.birthday,
      color: color ?? this.color,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      ownerId: ownerId,
      vaccinated: vaccinated ?? this.vaccinated,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
