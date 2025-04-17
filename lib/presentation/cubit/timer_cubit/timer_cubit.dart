import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:uuid/uuid.dart';


part 'timer_state.dart';

class TimerCubit extends Cubit<TimerCubitState> {
  TimerCubit() : super(TimerCubitInitial( duration: 10, rounds: 5, restTime: 5,uniqueId: Uuid().v4()));

  

  // Incrementar los rounds
  void increaseRounds(int value) => emit(TimerCubitInitial(
      duration: state.duration,
      restTime: state.restTime,
      rounds: state.rounds + value,
      uniqueId: Uuid().v4()
      ));

  // Decrementar los rounds
  void decreaseRounds(int value) {
    if(state.rounds > 1){
      emit(TimerCubitInitial(
        duration: state.duration,
        restTime: state.restTime,
        rounds: state.rounds - value,
          uniqueId: Uuid().v4()));
      }else emit(TimerCubitShowSnackbarRoundsState(
        duration: state.duration,
        restTime: state.restTime,
        rounds: state.rounds,
          uniqueId: Uuid().v4()
        ));
  }

  // Aumentar el tiempo de los rounds
  void increaseRoundTime(int value) => emit(TimerCubitInitial(
      duration: state.duration + value,
      restTime: state.restTime,
      rounds: state.rounds,
      uniqueId: Uuid().v4()
      ));


   // Decrementar el tiempo de los rounds
  void decreaseRoundTime(int value) {
    if(state.duration - value >= 5){
      emit(TimerCubitInitial(
        duration: state.duration - value,
        restTime: state.restTime,
        rounds: state.rounds,
        uniqueId: Uuid().v4()
        ));
      }
    else{
      emit(TimerCubitShowSnackbarRoundTimeState(
        duration: 5,
        restTime: state.restTime,
        rounds: state.rounds,
        uniqueId: Uuid().v4()
        ));
    }  
    }

    // Aumentar el tiempo de descanso
  void increaseRestTime(int value) => emit(TimerCubitInitial(
      duration: state.duration,
      restTime: state.restTime + value,
      rounds: state.rounds,
      uniqueId: Uuid().v4()
      ));


   // Decrementar el tiempo de descanso
  void decreaseRestTime(int value) {
    if( state.restTime - value >= 0){
      emit(TimerCubitInitial(
        duration: state.duration,
        restTime: state.restTime - value,
        rounds: state.rounds,
        uniqueId: Uuid().v4()
        ));
      }
    else{
      emit(TimerCubitInitial(
        duration: state.duration,
        restTime: 0,
        rounds: state.rounds,
        uniqueId: Uuid().v4()
        ));
      }  
    }

  }    


