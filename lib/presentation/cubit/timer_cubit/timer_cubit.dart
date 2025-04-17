import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:training_mma_timer/data/local/local_storage_service.dart';


import 'package:uuid/uuid.dart';


part 'timer_state.dart';

class TimerCubit extends Cubit<TimerCubitState> {
  final int duration;
  final int rounds;
  final int restTime;
  TimerCubit({required this.duration,required this.rounds,required this.restTime}) : super(TimerCubitInitial( duration: 10, rounds: 5, restTime: 5,uniqueId: Uuid().v4()));

  

  // Incrementar los rounds
  void increaseRounds(int value)  {
    LocalStorageService.saveTimer(
      duration: state.duration,
      restTime: state.restTime,
      rounds:  state.rounds + value,
      );

    emit(TimerCubitInitial(
      duration: state.duration,
      restTime: state.restTime,
      rounds: state.rounds + value,
      uniqueId: Uuid().v4()
      ));
      
      
      }

  // Decrementar los rounds
  void decreaseRounds(int value) {
    if(state.rounds > 1){
      LocalStorageService.saveTimer(
        duration: state.duration,
        restTime: state.restTime,
        rounds:  state.rounds - value,);

      emit(TimerCubitInitial(
        duration: state.duration,
        restTime: state.restTime,
        rounds: state.rounds - value,
        uniqueId: Uuid().v4()));

        

      }else{ 
        LocalStorageService.saveTimer(
        duration: state.duration,
        restTime: state.restTime,
        rounds:  state.rounds);
        
        emit(TimerCubitShowSnackbarRoundsState(
        duration: state.duration,
        restTime: state.restTime,
        rounds: state.rounds,
          uniqueId: Uuid().v4()
        ));}

        
  }

  // Aumentar el tiempo de los rounds
  void increaseRoundTime(int value) {
    LocalStorageService.saveTimer(
        duration: state.duration + value,
        restTime: state.restTime,
        rounds:  state.rounds,);


    emit(TimerCubitInitial(
      duration: state.duration + value,
      restTime: state.restTime,
      rounds: state.rounds,
      uniqueId: Uuid().v4()
      ));

      
      
      }


   // Decrementar el tiempo de los rounds
  void decreaseRoundTime(int value) {
    if(state.duration - value >= 5){
      LocalStorageService.saveTimer(
        duration: state.duration - value,
        restTime: state.restTime,
        rounds:  state.rounds,);

      emit(TimerCubitInitial(
        duration: state.duration - value,
        restTime: state.restTime,
        rounds: state.rounds,
        uniqueId: Uuid().v4()
        ));

        

      }
    else{
      LocalStorageService.saveTimer(
        duration: 5,
        restTime: state.restTime,
        rounds:  state.rounds,);

      emit(TimerCubitShowSnackbarRoundTimeState(
        duration: 5,
        restTime: state.restTime,
        rounds: state.rounds,
        uniqueId: Uuid().v4()
        ));
        
    }  
    }

    // Aumentar el tiempo de descanso
  void increaseRestTime(int value)  {
    LocalStorageService.saveTimer(
        duration: state.duration,
        restTime: state.restTime + value,
        rounds:  state.rounds,);

    emit(TimerCubitInitial(
      duration: state.duration,
      restTime: state.restTime + value,
      rounds: state.rounds,
      uniqueId: Uuid().v4()
      ));

      
      }


   // Decrementar el tiempo de descanso
  void decreaseRestTime(int value) {
    if( state.restTime - value >= 0){
      LocalStorageService.saveTimer(
        duration: state.duration,
        restTime: state.restTime - value,
        rounds:  state.rounds,);

      emit(TimerCubitInitial(
        duration: state.duration,
        restTime: state.restTime - value,
        rounds: state.rounds,
        uniqueId: Uuid().v4()
        ));
        
      
      }
    else{ LocalStorageService.saveTimer(
        duration: state.duration,
        restTime: 0,
        rounds:  state.rounds,);
      emit(TimerCubitInitial(
        duration: state.duration,
        restTime: 0,
        rounds: state.rounds,
        uniqueId: Uuid().v4()
        ));
       
      }  
    }

  }    


