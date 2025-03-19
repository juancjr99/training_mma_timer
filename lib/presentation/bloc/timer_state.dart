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

final class TimerInitial extends TimerState {
  const TimerInitial(super.duration, super.rounds, super.restTime, super.currentRounds);

  @override
  String toString() => 'TimerInitial { duration: $duration } { rounds: $rounds } { restime: $restTime }';
}

final class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration, super.rounds, super.restTime, super.currentRounds);

  @override
  String toString() => 'TimerRunPause { duration: $duration } { rounds: $rounds } { restime: $restTime }';
}

final class TimerRestPause extends TimerState {
  const TimerRestPause(super.duration, super.rounds, super.restTime, super.currentRounds);

  @override
  String toString() => 'TimerRunPause { duration: $duration } { rounds: $rounds } { restime: $restTime }';
}

final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration, super.rounds, super.restTime, super.currentRounds);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration } { rounds: $rounds } { restime: $restTime }';
}

final class TimerRestInProgress extends TimerState {
  const TimerRestInProgress(super.duration, super.rounds, super.restTime, super.currentRounds);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration } { rounds: $rounds } { restime: $restTime }';
}


final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0,0,0,0);
}

