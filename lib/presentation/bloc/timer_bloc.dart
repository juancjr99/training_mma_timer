import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_mma_timer/config/helpers/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {

  final Ticker _ticker;

  int _currentRound = 0;
  int _rounds = 0;
  int _roundDuration = 0;
  int _restDuration = 0;


  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker}) : _ticker = ticker, super(TimerInitial(0,0,0,0)) {

    on<TimerStarted>(_onStarted);
    on<_TimerTicked>(_onTicked);
    on<_TimerTickedRest>(_onTickedRest);
    on<TimerRunPaused>(_onPaused);
     on<TimerRestPaused>(_onResetPaused);
    on<TimerReset>(_onReset);
    on<TimerRunResumed>(_onResumed);
    on<TimerRestResumed>(_onRestResumed);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }


  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    print('TimerStarted { duration: ${event.duration} s} { rounds: ${event.rounds}  } { restime: ${event.restTime} s}');
    _rounds = event.rounds;
    _roundDuration = event.duration;
    _restDuration = event.restTime;
    _currentRound =event.currentRound; 


    emit(TimerRunInProgress(event.duration, event.rounds, event.restTime,event.currentRound));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTicked( duration: duration, rounds: _rounds, restTime: _restDuration, currentRound: _currentRound)));
  }

  void _onPaused(TimerRunPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration, state.rounds, state.restTime, state.currentRounds));
    }
  }

  void _onResetPaused(TimerRestPaused event, Emitter<TimerState> emit) {
    if (state is TimerRestInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRestPause(state.duration, state.rounds, state.restTime, state.currentRounds));
    }
  }

  void _onResumed(TimerRunResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration, state.rounds, state.restTime, state.currentRounds));
    }
  }

  void _onRestResumed(TimerRestResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRestPause) {
      _tickerSubscription?.resume();
      emit(TimerRestInProgress(state.duration, state.rounds, state.restTime, state.currentRounds));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    // TODO ARREGLAR EL ERROR DE ABAJO
    // emit(const TimerInitial(_roundDuration));
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    _currentRound = event.currentRound;
    if (event.duration > 0){
      emit(TimerRunInProgress(event.duration, event.rounds, event.restTime, state.currentRounds));
    }
    else if( event.duration <= 0 && event.currentRound == event.rounds){
      emit(TimerRunComplete());
    }
    else{
      emit(TimerRestInProgress(event.duration, event.rounds, event.restTime,event.currentRound));
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
        .tick(ticks: event.restTime)
        .listen((restTime) => add(_TimerTickedRest( duration: _roundDuration, rounds: _rounds, restTime: restTime, currentRound: _currentRound)));
  
    } 
  }

  void _onTickedRest(_TimerTickedRest event, Emitter<TimerState> emit) {
    if(event.restTime > 0 ){
      emit(TimerRestInProgress(event.duration, event.rounds, event.restTime, state.currentRounds));
    }
    else{
      emit(TimerRunInProgress(_roundDuration, event.rounds, _restDuration,event.currentRound +1));
              _tickerSubscription?.cancel();
              _tickerSubscription = _ticker
              .tick(ticks: event.duration)
              .listen((duration) => add(_TimerTicked( duration: duration, rounds: _rounds, restTime: _restDuration, currentRound: event.currentRound +1)));
    }
    }
}
