import 'package:demo_app/main/data/model/activity.dart';
import 'package:equatable/equatable.dart';

enum ActivityStatus { initial, loading, success, failure }

class ActivityState extends Equatable {
  final ActivityStatus status;
  final List<Activity> dailyActivities;
  final List<Activity> schedules;
  final String? selectedPetId;

  const ActivityState({
    this.status = ActivityStatus.initial,
    this.dailyActivities = const [],
    this.schedules = const [],
    this.selectedPetId,
  });

  ActivityState copyWith({
    ActivityStatus? status,
    List<Activity>? dailyActivities,
    List<Activity>? schedules,
    String? selectedPetId,
  }) {
    return ActivityState(
      status: status ?? this.status,
      dailyActivities: dailyActivities ?? this.dailyActivities,
      schedules: schedules ?? this.schedules,
      selectedPetId: selectedPetId ?? this.selectedPetId,
    );
  }

  @override
  List<Object?> get props => [status, dailyActivities, schedules, selectedPetId];
}
