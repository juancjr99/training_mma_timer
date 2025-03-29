part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState({required this.isSound,required this.isVibration,required this.isRotation,required this.isAlert});
  final bool isSound ;
  final bool isVibration;
  final bool isRotation;
  final bool isAlert;

  @override
  List<Object> get props => [isSound,isVibration,isRotation,isAlert];
}

final class SettingsInitialState extends SettingsState {
  SettingsInitialState({required super.isSound, required super.isVibration, required super.isRotation, required super.isAlert});
}
