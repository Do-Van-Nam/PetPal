import 'package:demo_app/main/data/model/activity.dart';
import 'package:equatable/equatable.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object?> get props => [];
}

class ActivityInitialized extends ActivityEvent {
  final String petId;
  const ActivityInitialized(this.petId);

  @override
  List<Object?> get props => [petId];
}

class AddActivityEvent extends ActivityEvent {
  final Activity activity;
  const AddActivityEvent(this.activity);

  @override
  List<Object?> get props => [activity];
}

class UpdateActivityEvent extends ActivityEvent {
  final Activity activity;
  const UpdateActivityEvent(this.activity);

  @override
  List<Object?> get props => [activity];
}

class DeleteActivityEvent extends ActivityEvent {
  final String activityId;
  const DeleteActivityEvent(this.activityId);

  @override
  List<Object?> get props => [activityId];
}

class ToggleActivityDoneEvent extends ActivityEvent {
  final Activity activity;
  const ToggleActivityDoneEvent(this.activity);

  @override
  List<Object?> get props => [activity];
}
