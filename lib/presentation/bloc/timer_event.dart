part of 'timer_bloc.dart';

@immutable
sealed class TimerEvent  {
  const TimerEvent();
}

final class TimerStartedEvent extends TimerEvent {
  const TimerStartedEvent({
    required this.duration,
    required this.rounds,
    required this.restTime,
    });

  final int duration;
  final int rounds;
  final int restTime;
  final int currentRound = 1;
}

final class TimerRunPausedEvent extends TimerEvent {
  const TimerRunPausedEvent();
}

final class TimerRestPausedEvent extends TimerEvent {
  const TimerRestPausedEvent();
}

final class TimerRunResumedEvent extends TimerEvent {
  const TimerRunResumedEvent();
}

final class TimerRestResumedEvent extends TimerEvent {
  const TimerRestResumedEvent();
}

class TimerResetEvent extends TimerEvent {
  const TimerResetEvent();
}

class _TimerTickedEvent extends TimerEvent {
  const _TimerTickedEvent({required this.duration, required this.rounds,  required this.restTime, required this.currentRound, });
  final int duration;
  final int rounds;
  final int restTime;
  final int currentRound;
}

class _TimerTickedRestEvent extends TimerEvent {
  const _TimerTickedRestEvent({required this.duration, required this.rounds,  required this.restTime, required this.currentRound, });
  final int duration;
  final int rounds;
  final int restTime;
  final int currentRound;
}

