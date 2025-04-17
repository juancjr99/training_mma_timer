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

final class TimerPreStartedEvent extends TimerEvent {
  const TimerPreStartedEvent({
    required this.duration,
    required this.rounds,
    required this.restTime,
    });

  final int duration;
  final int rounds;
  final int restTime;
  final int currentRound = 1;
}

// final class TimerWarmUpEvent extends TimerEvent {
//   const TimerWarmUpEvent();
// }

final class TimerRunPausedEvent extends TimerEvent {
  const TimerRunPausedEvent();
}

final class TimerPreStartPausedEvent extends TimerEvent {
  const TimerPreStartPausedEvent();
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

final class TimerPreStartResumedEvent extends TimerEvent {
  const TimerPreStartResumedEvent();
}

class TimerResetEvent extends TimerEvent {
  const TimerResetEvent();
}

class TimerFinishEvent extends TimerEvent {
  const TimerFinishEvent();
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


class _TimerTickedPreStartEvent extends TimerEvent {
  const _TimerTickedPreStartEvent({required this.duration, required this.rounds,  required this.restTime, required this.currentRound, });
final int duration;
  final int rounds;
  final int restTime;
  final int currentRound;
}

// class StartForegroundService extends TimerEvent {}

// class PauseForegroundService extends TimerEvent {}

// class CancelForegroundService extends TimerEvent {}

// class ForegroundButtonPressed extends TimerEvent {
//   final String buttonId;
//   ForegroundButtonPressed(this.buttonId);
// }
