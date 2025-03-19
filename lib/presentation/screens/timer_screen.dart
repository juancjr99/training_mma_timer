import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_mma_timer/config/helpers/ticker.dart';
import 'package:training_mma_timer/presentation/bloc/timer_bloc.dart';
import 'package:training_mma_timer/presentation/screens/widgets/timer_actions.dart';

class TimerScreen extends StatelessWidget {
  static const name = 'Timer Scree';
  const TimerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(ticker: Ticker()),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Timer')),
      body: Stack(
        children: [
          // const Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Column(
                  children: [
                    Center(child: Current_Round()),
                    Center(child: TimerText()),
                  ],
                ),
              ),
              TimerActions(),
            ],
          ),
        ],
      ),
    );
  }
}

class Current_Round extends StatelessWidget {
  const Current_Round({super.key});

  @override
  Widget build(BuildContext context) {
    final rounds = context.select((TimerBloc bloc) => bloc.state.rounds);
    final currentRounds =
        context.select((TimerBloc bloc) => bloc.state.currentRounds);

    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return switch (state) {
          TimerInitial() => Text("Let's get started!",
              style: Theme.of(context).textTheme.headlineLarge),
          TimerRunPause() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Paused',
                  style: Theme.of(context).textTheme.headlineLarge),

              Text('$currentRounds/$rounds',
                  style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
          TimerRestPause() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Paused',
                  style: Theme.of(context).textTheme.headlineLarge),

              Text('Rest Time', style: Theme.of(context).textTheme.headlineLarge),
            ],
          ), 
          TimerRunInProgress() => Text('$currentRounds/$rounds',
              style: Theme.of(context).textTheme.headlineLarge),
          TimerRestInProgress() =>
            Text('Rest Time', style: Theme.of(context).textTheme.headlineLarge),
          TimerRunComplete() => Text('You made it!!!',
              style: Theme.of(context).textTheme.headlineLarge),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final restTime = context.select((TimerBloc bloc) => bloc.state.restTime);

    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return switch (state) {
          TimerInitial() => const SizedBox.shrink(), 
          TimerRunInProgress() => Text('${_toMinutesStr(duration)}:${_toSecondsStr(duration)}', style: Theme.of(context).textTheme.headlineLarge,   ),
          TimerRestInProgress() => Text('${_toMinutesStr(restTime)}:${_toSecondsStr(restTime)}', style: Theme.of(context).textTheme.headlineLarge,   ),
          TimerRunComplete() => const SizedBox.shrink(), 
          TimerRunPause() => Text('${_toMinutesStr(duration)}:${_toSecondsStr(duration)}', style: Theme.of(context).textTheme.headlineLarge,   ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}


String _toMinutesStr(int duration) {
  return ((duration / 60) % 60).floor().toString().padLeft(2, '0');
}

String _toSecondsStr(int duration) {
  return (duration % 60).floor().toString().padLeft(2, '0');
}
