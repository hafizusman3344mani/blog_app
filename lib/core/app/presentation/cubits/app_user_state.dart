part of '../cubits/app_user_cubit.dart';

final class AppUserState {
  final UserEntity? userEntity;
  final AppUserStatus userStatus;
  final String message;

  AppUserState({this.userEntity, required this.userStatus, this.message = ''});

  factory AppUserState.initial() {
    return AppUserState(userStatus: AppUserStatus.loading);
  }

  AppUserState copyWith(
      {UserEntity? userEntity, AppUserStatus? userStatus, String? message}) {
    return AppUserState(
      message: message ?? '',
      userEntity: userEntity,
      userStatus: userStatus ?? this.userStatus,
    );
  }
}

enum AppUserStatus { loading, loaded, error }
