import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  final String userName;
  final String userEmail;
  final bool isProMember;
  final bool notificationsEnabled;
  final bool locationEnabled;
  final bool isLoading;

  const SettingState({
    this.userName = '',
    this.userEmail = '',
    this.isProMember = false,
    this.notificationsEnabled = true,
    this.locationEnabled = true,
    this.isLoading = false,
  });

  SettingState copyWith({
    String? userName,
    String? userEmail,
    bool? isProMember,
    bool? notificationsEnabled,
    bool? locationEnabled,
    bool? isLoading,
  }) {
    return SettingState(
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      isProMember: isProMember ?? this.isProMember,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        userName,
        userEmail,
        isProMember,
        notificationsEnabled,
        locationEnabled,
        isLoading,
      ];
}
