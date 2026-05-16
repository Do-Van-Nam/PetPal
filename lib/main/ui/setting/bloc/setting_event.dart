import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettingEvent extends SettingEvent {}

class UpdateNotificationEvent extends SettingEvent {
  final bool isEnabled;
  const UpdateNotificationEvent(this.isEnabled);

  @override
  List<Object?> get props => [isEnabled];
}

class UpdateLocationEvent extends SettingEvent {
  final bool isEnabled;
  const UpdateLocationEvent(this.isEnabled);

  @override
  List<Object?> get props => [isEnabled];
}
