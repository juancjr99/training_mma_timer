part of 'timer_bloc.dart';

@immutable
sealed class TimerEvent  {
  const TimerEvent();
}

final class TimerStarted extends TimerEvent {
  const TimerStarted({
    required this.duration,
    required this.rounds,
    required this.restTime,
    });

  final int duration;
  final int rounds;
  final int restTime;
  final int currentRound = 1;
}

final class TimerRunPaused extends TimerEvent {
  const TimerRunPaused();
}

final class TimerRestPaused extends TimerEvent {
  const TimerRestPaused();
}

final class TimerRunResumed extends TimerEvent {
  const TimerRunResumed();
}

final class TimerRestResumed extends TimerEvent {
  const TimerRestResumed();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class _TimerTicked extends TimerEvent {
  const _TimerTicked({required this.duration, required this.rounds,  required this.restTime, required this.currentRound, });
  final int duration;
  final int rounds;
  final int restTime;
  final int currentRound;
}

class _TimerTickedRest extends TimerEvent {
  const _TimerTickedRest({required this.duration, required this.rounds,  required this.restTime, required this.currentRound, });
  final int duration;
  final int rounds;
  final int restTime;
  final int currentRound;
}

