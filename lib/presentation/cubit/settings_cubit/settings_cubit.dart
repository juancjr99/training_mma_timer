import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:training_mma_timer/data/local/local_storage_service.dart';

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


    void sound() {
      LocalStorageService.saveSettings(
      isSound: !state.isSound,
      isAlert: state.isAlert,
      isRotation: state.isRotation,
      isVibration: state.isVibration,
      );
      
      emit(SettingsInitialState(
      isSound: !state.isSound,
      isAlert: state.isAlert,
      isRotation: state.isRotation,
      isVibration: state.isVibration
      ));

      

      }

    void alert() { 
      LocalStorageService.saveSettings(
      isSound: state.isSound,
      isAlert: !state.isAlert,
      isRotation: state.isRotation,
      isVibration: state.isVibration,
    );

      emit(SettingsInitialState(
      isSound: state.isSound,
      isAlert: !state.isAlert,
      isRotation: state.isRotation,
      isVibration: state.isVibration
      ));

      
    }  

      void rotation()  {
      LocalStorageService.saveSettings(
      isSound: state.isSound,
      isAlert: state.isAlert,
      isRotation: !state.isRotation,
      isVibration: state.isVibration,
      );  
      emit(SettingsInitialState(
      isSound: state.isSound,
      isAlert: state.isAlert,
      isRotation: !state.isRotation,
      isVibration: state.isVibration
      ));
      
      }

      void vibration()  {
      LocalStorageService.saveSettings(
      isSound: state.isSound,
      isAlert: state.isAlert,
      isRotation: state.isRotation,
      isVibration: !state.isVibration,
  );  
        
      emit(SettingsInitialState(
      isSound: state.isSound,
      isAlert: state.isAlert,
      isRotation: state.isRotation,
      isVibration: !state.isVibration
      ));  
      
      }

}
