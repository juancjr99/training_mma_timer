part of 'timer_bloc.dart';

@immutable
sealed class TimerState extends Equatable{
  const TimerState(this.duration, this.rounds, this.restTime, this.currentRounds);
  final int duration;
  final int rounds;
  final int restTime;
  final int currentRounds;

  @override
  List<Object> get props => [duration,rounds,restTime, currentRounds];

}

final class TimerInitialState extends TimerState {
  const TimerInitialState(super.duration, super.rounds, super.restTime, super.currentRounds);

  @override
  String toString() => 'TimerInitialState { duration: $duration } { rounds: $rounds } { restime: $restTime }';
}

final class TimerRunPauseState extends TimerState {
  const TimerRunPauseState(super.duration, super.rounds, super.restTime, super.currentRounds);

  @override
  String toString() => 'TimerRunPauseState { duration: $duration } { rounds: $rounds } { restime: $restTime }';
}

final class TimerRestPauseState extends TimerState {
  const TimerRestPauseState(super.duration, super.rounds, super.restTime, super.currentRounds);

  @override
  String toString() => 'TimerRestPauseState { duration: $duration } { rounds: $rounds } { restime: $restTime }';
}

final class TimerRunInProgressState extends TimerState {
  const TimerRunInProgressState(super.duration, super.rounds, super.restTime, super.currentRounds);

  @override
  String toString() => 'TimerRunInProgressState { duration: $duration } { rounds: $rounds } { restime: $restTime }';
}

final class TimerRestInProgressState extends TimerState {
  const TimerRestInProgressState(super.duration, super.rounds, super.restTime, super.currentRounds);

  @override
  String toString() => 'TimerRestInProgressState { duration: $duration } { rounds: $rounds } { restime: $restTime }';
}


final class TimerRunCompleteState extends TimerState {
  const TimerRunCompleteState() : super(0,0,0,0);
}

