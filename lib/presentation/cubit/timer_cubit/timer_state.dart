part of 'timer_cubit.dart';

sealed class TimerCubitState extends Equatable {
  const TimerCubitState({required this.duration, required this.rounds, required this.restTime});
  final int duration;
  final int rounds;
  final int restTime;
  @override
  List<Object> get props => [duration, rounds, restTime];
}

final class TimerCubitInitial extends TimerCubitState {
  TimerCubitInitial({required super.duration, required super.rounds, required super.restTime});
}
