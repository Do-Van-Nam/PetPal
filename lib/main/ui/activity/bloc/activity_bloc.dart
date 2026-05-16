import 'package:demo_app/main/data/database/activity_db_helper.dart';
import 'package:demo_app/main/data/model/activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'activity_event.dart';
import 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityDbHelper _activityDbHelper = ActivityDbHelper.instance;

  ActivityBloc() : super(const ActivityState()) {
    on<ActivityInitialized>(_onActivityInitialized);
    on<AddActivityEvent>(_onAddActivity);
    on<UpdateActivityEvent>(_onUpdateActivity);
    on<DeleteActivityEvent>(_onDeleteActivity);
    on<ToggleActivityDoneEvent>(_onToggleActivityDone);
  }

  Future<void> _onActivityInitialized(
      ActivityInitialized event, Emitter<ActivityState> emit) async {
    emit(state.copyWith(status: ActivityStatus.loading, selectedPetId: event.petId));

    try {
      final activities = await _activityDbHelper.loadActivitiesByPet(event.petId);
      
      final dailyActivities = activities
          .where((a) => a.activityType == ActivityType.daily)
          .toList();
      final schedules = activities
          .where((a) => a.activityType == ActivityType.schedule)
          .toList();

      emit(state.copyWith(
        status: ActivityStatus.success,
        dailyActivities: dailyActivities,
        schedules: schedules,
      ));
    } catch (e) {
      emit(state.copyWith(status: ActivityStatus.failure));
    }
  }

  Future<void> _onAddActivity(
      AddActivityEvent event, Emitter<ActivityState> emit) async {
    try {
      await _activityDbHelper.saveActivity(event.activity);
      add(ActivityInitialized(state.selectedPetId!));
    } catch (e) {
      emit(state.copyWith(status: ActivityStatus.failure));
    }
  }

  Future<void> _onUpdateActivity(
      UpdateActivityEvent event, Emitter<ActivityState> emit) async {
    try {
      await _activityDbHelper.saveActivity(event.activity);
      add(ActivityInitialized(state.selectedPetId!));
    } catch (e) {
      emit(state.copyWith(status: ActivityStatus.failure));
    }
  }

  Future<void> _onDeleteActivity(
      DeleteActivityEvent event, Emitter<ActivityState> emit) async {
    try {
      await _activityDbHelper.deleteActivity(event.activityId);
      add(ActivityInitialized(state.selectedPetId!));
    } catch (e) {
      emit(state.copyWith(status: ActivityStatus.failure));
    }
  }

  Future<void> _onToggleActivityDone(
      ToggleActivityDoneEvent event, Emitter<ActivityState> emit) async {
    try {
      final updatedActivity = event.activity.copyWith(
        isDone: !(event.activity.isDone ?? false),
      );
      await _activityDbHelper.saveActivity(updatedActivity);
      add(ActivityInitialized(state.selectedPetId!));
    } catch (e) {
      emit(state.copyWith(status: ActivityStatus.failure));
    }
  }
}
