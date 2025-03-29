import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:training_mma_timer/config/helpers/ticker.dart';
import 'package:vibration/vibration.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {

  final Ticker _ticker;
  final int duration;
  final int rounds;
  final int restTime;

  final bool isSound ;
  final bool isVibration;
  final bool isRotation;
  final bool isAlert;

  int _currentRound = 0;
  int _rounds = 0;
  int _roundDuration = 0;
  int _restDuration = 0;
  int _preStartDuration = 5;

  final player = AudioPlayer();
  final assetSource = AssetSource('sounds/beep-07a.mp3');

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({
    required this.isSound,
    required this.isVibration,
    required this.isRotation,
    required this.isAlert, 
    required this.duration,
    required this.rounds,
    required this.restTime,
    required Ticker ticker}) : _ticker = ticker, super(TimerInitialState(duration,rounds,restTime,0)) {

     // Precargar sonido una vez
    _preloadSound();

    // on<TimerWarmUpEvent>(_onWarmUp);
    on<TimerPreStartPausedEvent>(_onPreStartPaused);
    on<TimerPreStartResumedEvent>(_onPreStartResumed);

    on<_TimerTickedPreStartEvent>(_onTickedPreStart);
    on<TimerFinishEvent>(_onFinish);

    on<TimerStartedEvent>(_onStarted);
    on<TimerPreStartedEvent>(_onPreStarted);

    on<TimerRunPausedEvent>(_onPaused);
    on<TimerRunResumedEvent>(_onResumed);
    on<_TimerTickedEvent>(_onTicked);

  
    
    on<TimerRestPausedEvent>(_onResetPaused);
    on<TimerRestResumedEvent>(_onRestResumed);
    on<_TimerTickedRestEvent>(_onTickedRest);

    on<TimerResetEvent>(_onReset);

    
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Future<void> _preloadSound() async {
    await player.setSourceAsset('sounds/beep-07a.mp3');
  }

  void _vibrate() async{
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }

  
  // void _onWarmUp(TimerStartedEvent event, Emitter<TimerState> emit) {
  //   print('TimerStarted { duration: ${event.duration} s} { rounds: ${event.rounds}  } { restime: ${event.restTime} s}');
  //   _rounds = event.rounds;
  //   _roundDuration = event.duration;
  //   _restDuration = event.restTime;
  //   _currentRound =event.currentRound; 


  //   emit(TimerRunInProgressState(event.duration, event.rounds, event.restTime,event.currentRound));
  //   _tickerSubscription?.cancel();
  //   _tickerSubscription = _ticker
  //       .tick(ticks: event.duration)
  //       .listen((duration) => add(_TimerTickedEvent( duration: duration, rounds: _rounds, restTime: _restDuration, currentRound: _currentRound)));
  // }


  void _onPreStarted(TimerPreStartedEvent event, Emitter<TimerState> emit) {
    _rounds = event.rounds;
    _roundDuration = event.duration;
    _restDuration = event.restTime;
    _currentRound =event.currentRound; 


    emit(TimerPreStartInProgressState(_preStartDuration, event.rounds, event.restTime,event.currentRound));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: _preStartDuration)
        .listen((duration) => add(_TimerTickedPreStartEvent( duration: duration, rounds: _rounds, restTime: _restDuration, currentRound: _currentRound)));
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

  void _onPreStartPaused(TimerPreStartPausedEvent event, Emitter<TimerState> emit) {
    if (state is TimerPreStartInProgressState) {
      _tickerSubscription?.pause();
      emit(TimerPreStartPauseState(state.duration, state.rounds, state.restTime, state.currentRounds));
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

  void _onPreStartResumed(TimerPreStartResumedEvent resume, Emitter<TimerState> emit) {
    if (state is TimerPreStartPauseState) {
      _tickerSubscription?.resume();
      emit(TimerPreStartInProgressState(state.duration, state.rounds, state.restTime, state.currentRounds));
    }
  }

  void _onReset(TimerResetEvent event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    // TODO ARREGLAR EL ERROR DE ABAJO
    emit(const TimerInitialState(20, 5, 5, 1));
  }

  void _onTicked(_TimerTickedEvent event, Emitter<TimerState> emit) async{
    _currentRound = event.currentRound;
    // // 🔊 Reproducir sonido
    if(event.duration <= 3 && event.duration >= 0 && isSound){
      await player.play(assetSource); // Asegúrate de tener el archivo en assets
    }

     if(event.duration == 0  && isVibration){
      _vibrate();
    }


    if (event.duration > -1){
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

  void _onTickedRest(_TimerTickedRestEvent event, Emitter<TimerState> emit) async{
    // // 🔊 Reproducir sonido
    if(event.restTime <= 3 && event.restTime >= 0 && isSound){
      await player.play(assetSource); // Asegúrate de tener el archivo en assets
    }

    if(event.restTime == 0  && isVibration){
      _vibrate();
    }
  

    if(event.restTime > -1 ){
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

  void _onTickedPreStart(_TimerTickedPreStartEvent event, Emitter<TimerState> emit) async{
    print(event.duration);
    // //Reproducir sonido aqui
    // // 🔊 Reproducir sonido
    if(event.duration <= 3 && event.duration >= 0  && isSound){
      await player.play(assetSource); // Asegúrate de tener el archivo en assets
    }

    if(event.duration == 0  && isVibration){
      _vibrate();
    }
  
    

    if(event.duration > -1 ){
      emit(TimerPreStartInProgressState(event.duration, event.rounds, event.restTime, state.currentRounds));
    }
    else{
      emit(TimerStartState(event.duration +1 , _rounds, _restDuration, 0));
    }
    }  

  void _onFinish(TimerFinishEvent resume, Emitter<TimerState> emit) {

    emit(TimerRunCompleteState());
    
  }

    
}

