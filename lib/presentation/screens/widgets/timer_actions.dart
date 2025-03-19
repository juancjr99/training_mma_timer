import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_mma_timer/presentation/bloc/timer_bloc.dart';

class TimerActions extends StatelessWidget {
  const TimerActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStarted(duration: 5, rounds: 3, restTime: 3)),
                  ),
                ],
              TimerRunInProgress() => [
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.pause),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerRunPaused()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],

                TimerRestInProgress() => [
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.pause),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerRestPaused()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],


              TimerRunPause() => [
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.play_arrow),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerRunResumed()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],

                TimerRestPause() => [
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.play_arrow),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerRestResumed()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],



              TimerRunComplete() => [
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],
            }
          ],
        );
      },
    );
  }
}