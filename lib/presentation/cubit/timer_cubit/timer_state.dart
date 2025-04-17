part of 'timer_cubit.dart';

sealed class TimerCubitState extends Equatable {
  const TimerCubitState({required this.duration, required this.rounds, required this.restTime, required this.uniqueId,});
  final int duration;
  final int rounds;
  final int restTime;
  final String uniqueId;
  @override
  List<Object> get props => [duration, rounds, restTime,uniqueId];
}

final class TimerCubitInitial extends TimerCubitState {
  TimerCubitInitial({required super.duration, required super.rounds, required super.restTime, required super.uniqueId});
}

final class TimerCubitShowSnackbarRoundTimeState extends TimerCubitState {
  TimerCubitShowSnackbarRoundTimeState({required super.duration, required super.rounds, required super.restTime, required super.uniqueId});
}

final class TimerCubitShowSnackbarRoundsState extends TimerCubitState {
  TimerCubitShowSnackbarRoundsState({required super.duration, required super.rounds, required super.restTime, required super.uniqueId});
}

