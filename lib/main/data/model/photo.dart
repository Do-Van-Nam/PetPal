class Photo {
  final String id;
  final String petId;
  final String caption;
  final String path; // duong dan anh dai dien
  final DateTime? createdAt; // ngay tao
  final DateTime? updatedAt; // ngay cap nhat

  Photo({
    required this.id,
    required this.petId,
    required this.caption,
    required this.path,
    this.createdAt,
    this.updatedAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id']?.toString() ?? '',
      petId: json['pet_id']?.toString() ?? '',
      caption: json['caption'] ?? '',
      path: json['path'] ?? '',
      createdAt: _parseDate(json['created_at']),
      updatedAt: _parseDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet_id': petId,
      'caption': caption,
      'path': path,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Photo copyWith({
    String? id,
    String? petId,
    String? caption,
    String? path,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Photo(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      caption: caption ?? this.caption,
      path: path ?? this.path,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }
}
