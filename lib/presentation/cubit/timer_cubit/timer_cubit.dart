import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerCubitState> {
  TimerCubit() : super(TimerCubitInitial( duration: 10, rounds: 5, restTime: 5));

  // Incrementar los rounds
  void increaseRounds(int value) => emit(TimerCubitInitial(
      duration: state.duration,
      restTime: state.restTime,
      rounds: state.rounds + value));

  // Decrementar los rounds
  void decreaseRounds(int value) {
    if(state.rounds > 1){
      emit(TimerCubitInitial(
        duration: state.duration,
        restTime: state.restTime,
        rounds: state.rounds - value));
      }
  }

  // Aumentar el tiempo de los rounds
  void increaseRoundTime(int value) => emit(TimerCubitInitial(
      duration: state.duration + value,
      restTime: state.restTime,
      rounds: state.rounds));


   // Decrementar el tiempo de los rounds
  void decreaseRoundTime(int value) {
    if(state.duration - value >= 0){
      emit(TimerCubitInitial(
        duration: state.duration - value,
        restTime: state.restTime,
        rounds: state.rounds));
      }
    else{
      emit(TimerCubitInitial(
        duration: 0,
        restTime: state.restTime,
        rounds: state.rounds));
    }  
    }

    // Aumentar el tiempo de los rounds
  void increaseRestTime(int value) => emit(TimerCubitInitial(
      duration: state.duration,
      restTime: state.restTime + value,
      rounds: state.rounds));


   // Decrementar el tiempo de los rounds
  void decreaseRestTime(int value) {
    if( state.restTime - value >= 0){
      emit(TimerCubitInitial(
        duration: state.duration,
        restTime: state.restTime - value,
        rounds: state.rounds));
      }
    else{
      emit(TimerCubitInitial(
        duration: state.duration,
        restTime: 0,
        rounds: state.rounds));
      }  
    }

  }    


