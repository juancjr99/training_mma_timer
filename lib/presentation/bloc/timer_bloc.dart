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

  TimerBloc({required Ticker ticker}) : _ticker = ticker, super(TimerInitialState(0,0,0,0)) {

    on<TimerStartedEvent>(_onStarted);
    on<_TimerTickedEvent>(_onTicked);
    on<_TimerTickedRestEvent>(_onTickedRest);
    on<TimerRunPausedEvent>(_onPaused);
    on<TimerRestPausedEvent>(_onResetPaused);
    on<TimerResetEvent>(_onReset);
    on<TimerRunResumedEvent>(_onResumed);
    on<TimerRestResumedEvent>(_onRestResumed);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }


  void _onStarted(TimerStartedEvent event, Emitter<TimerState> emit) {
    print('TimerStarted { duration: ${event.duration} s} { rounds: ${event.rounds}  } { restime: ${event.restTime} s}');
    _rounds = event.rounds;
    _roundDuration = event.duration;
    _restDuration = event.restTime;
    _currentRound =event.currentRound; 


    emit(TimerRunInProgressState(event.duration, event.rounds, event.restTime,event.currentRound));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTickedEvent( duration: duration, rounds: _rounds, restTime: _restDuration, currentRound: _currentRound)));
  }

  void _onPaused(TimerRunPausedEvent event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgressState) {
      _tickerSubscription?.pause();
      emit(TimerRunPauseState(state.duration, state.rounds, state.restTime, state.currentRounds));
    }
  }

  void _onResetPaused(TimerRestPausedEvent event, Emitter<TimerState> emit) {
    if (state is TimerRestInProgressState) {
      _tickerSubscription?.pause();
      emit(TimerRestPauseState(state.duration, state.rounds, state.restTime, state.currentRounds));
    }
  }

  void _onResumed(TimerRunResumedEvent resume, Emitter<TimerState> emit) {
    if (state is TimerRunPauseState) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgressState(state.duration, state.rounds, state.restTime, state.currentRounds));
    }
  }

  void _onRestResumed(TimerRestResumedEvent resume, Emitter<TimerState> emit) {
    if (state is TimerRestPauseState) {
      _tickerSubscription?.resume();
      emit(TimerRestInProgressState(state.duration, state.rounds, state.restTime, state.currentRounds));
    }
  }

  void _onReset(TimerResetEvent event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    // TODO ARREGLAR EL ERROR DE ABAJO
    emit(const TimerInitialState(20, 5, 5, 1));
  }

  void _onTicked(_TimerTickedEvent event, Emitter<TimerState> emit) {
    _currentRound = event.currentRound;
    if (event.duration > 0){
      emit(TimerRunInProgressState(event.duration, event.rounds, event.restTime, state.currentRounds));
    }
    else if( event.duration <= 0 && event.currentRound == event.rounds){
      emit(TimerRunCompleteState());
    }
    else{
      emit(TimerRestInProgressState(event.duration, event.rounds, event.restTime,event.currentRound));
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker
        .tick(ticks: event.restTime)
        .listen((restTime) => add(_TimerTickedRestEvent( duration: _roundDuration, rounds: _rounds, restTime: restTime, currentRound: _currentRound)));
  
    } 
  }

  void _onTickedRest(_TimerTickedRestEvent event, Emitter<TimerState> emit) {
    if(event.restTime > 0 ){
      emit(TimerRestInProgressState(event.duration, event.rounds, event.restTime, state.currentRounds));
    }
    else{
      emit(TimerRunInProgressState(_roundDuration, event.rounds, _restDuration,event.currentRound +1));
              _tickerSubscription?.cancel();
              _tickerSubscription = _ticker
              .tick(ticks: event.duration)
              .listen((duration) => add(_TimerTickedEvent( duration: duration, rounds: _rounds, restTime: _restDuration, currentRound: event.currentRound +1)));
    }
    }


    
}

