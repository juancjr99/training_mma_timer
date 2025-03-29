import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  
  final bool isSound ;
  final bool isVibration;
  final bool isRotation;
  final bool isAlert;
  SettingsCubit({
    required this.isSound,
    required this.isVibration,
    required this.isRotation,
    required this.isAlert}) : super(SettingsInitialState(
                                      isSound: isSound,
                                      isAlert: isAlert,
                                      isRotation: isRotation,
                                      isVibration: isVibration));

    void sound() => emit(SettingsInitialState(
      isSound: !state.isSound,
      isAlert: state.isAlert,
      isRotation: state.isRotation,
      isVibration: state.isVibration
      ));

    void alert() => emit(SettingsInitialState(
      isSound: state.isSound,
      isAlert: !state.isAlert,
      isRotation: state.isRotation,
      isVibration: state.isVibration
      ));  

      void rotation() => emit(SettingsInitialState(
      isSound: state.isSound,
      isAlert: state.isAlert,
      isRotation: !state.isRotation,
      isVibration: state.isVibration
      ));

      void vibration() => emit(SettingsInitialState(
      isSound: state.isSound,
      isAlert: state.isAlert,
      isRotation: state.isRotation,
      isVibration: !state.isVibration
      ));  

}
