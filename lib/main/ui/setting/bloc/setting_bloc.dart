import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_event.dart';
import 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState()) {
    on<LoadSettingEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      // Simulate loading user data
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(
        isLoading: false,
        userName: 'Sarah Jenks',
        userEmail: 'sarah.jenks@example.com',
        isProMember: true,
      ));
    });

    on<UpdateNotificationEvent>((event, emit) {
      emit(state.copyWith(notificationsEnabled: event.isEnabled));
    });

    on<UpdateLocationEvent>((event, emit) {
      emit(state.copyWith(locationEnabled: event.isEnabled));
    });
  }
}
