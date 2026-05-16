enum ActivityType {
  daily,
  schedule;
}

class Activity {
  final String id;
  final String petId;
  final ActivityType activityType;
  final String description; // mo ta
  final bool? isDone;
  final DateTime? date; // ngay tao

  Activity({
    required this.id,
    required this.petId,
    required this.activityType,
    required this.description,
    this.isDone,
    this.date,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id']?.toString() ?? '',
      petId: json['pet_id']?.toString() ?? '',
      activityType: _parseActivityType(json['activity_type']),
      description: json['description']?.toString() ?? '',
      isDone: json['is_done'] == true ||
          json['is_done'] == 1 ||
          json['is_done'] == 'true',
      date: _parseDate(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pet_id': petId,
      'activity_type': activityType.name,
      'description': description,
      'is_done': isDone,
      'date': date?.toIso8601String(),
    };
  }

  Activity copyWith({
    String? id,
    String? petId,
    ActivityType? activityType,
    String? description,
    bool? isDone,
    DateTime? date,
  }) {
    return Activity(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      activityType: activityType ?? this.activityType,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      date: date ?? this.date,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static ActivityType _parseActivityType(dynamic value) {
    final v = value?.toString().toLowerCase();
    try {
      return ActivityType.values.firstWhere((t) => t.name == v);
    } catch (_) {
      return ActivityType.daily;
    }
  }

  String parseDateToString(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }
}
