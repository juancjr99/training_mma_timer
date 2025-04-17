import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_mma_timer/presentation/bloc/timer_bloc.dart';
import 'package:training_mma_timer/presentation/cubit/timer_cubit/timer_cubit.dart';

class TimerActions extends StatelessWidget {
  const TimerActions({super.key, required this.timerCubit});
  final TimerCubit timerCubit;
  void openDialog(BuildContext context){
    // final timerBloc = context.read<TimerBloc>(); // Guarda el Bloc antes de abrir el diálogo

    showDialog(context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
        title: const Text('Estas seguro?'),
        content: const Text('Desea detener el entrenamiento?'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('No, Continuar', style: TextStyle(color: Colors.white),)),
        
          FilledButton(
            onPressed: (){ 
              // timerBloc.add(TimerFinishEvent());
              context.pop();
              context.pop(); // Solo cierra la pantalla si es posible

            },
            child: const Text('Si',  style: TextStyle(color: Colors.white)),
            style: FilledButton.styleFrom(backgroundColor:  Color(0xFFCE090A),),
            ),
            
        ],
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        if(state is TimerStartState){
          context
              .read<TimerBloc>()
              .add(TimerStartedEvent(duration: timerCubit.state.duration, rounds: timerCubit.state.rounds, restTime: timerCubit.state.restTime));
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitialState() => [
                  FloatingActionButton(
                    heroTag: 'fab2', // <- dale un tag único
                    child: const Icon(Icons.play_arrow),
                    onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStartedEvent(duration: timerCubit.state.duration, rounds: timerCubit.state.rounds, restTime: timerCubit.state.restTime)),
                  ),


                ],
              TimerRunInProgressState() => [
                  FloatingActionButton(
                    heroTag: 'fab3', // <- dale un tag único
                      child: const Icon(Icons.pause),
                      onPressed: () =>
                          context.read<TimerBloc>().add(const TimerRunPausedEvent()),
                    ),

                  
                  // FloatingActionButton(
                  //     child: const Icon(Icons.replay),
                  //     onPressed: () { 
                  //       context.read<TimerBloc>().add(const TimerRunPausedEvent());
                  //       openDialog(context);
                  //       }
                  //         // context.read<TimerBloc>().add(const TimerResetEvent()),
                  //   ),
                
                ],

                TimerRestInProgressState() => [
                  FloatingActionButton(
                    heroTag: 'fab4', // <- dale un tag único
                    child: const Icon(Icons.pause),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerRestPausedEvent()),
                  ),
                  // FloatingActionButton(
                  //   child: const Icon(Icons.replay),
                  //   onPressed: () =>
                  //       context.read<TimerBloc>().add(const TimerResetEvent()),
                  // ),
                ],


              TimerRunPauseState() => [
                  FadeInRight(
                    duration: Duration(milliseconds: 200),
                    child: FloatingActionButton(
                      heroTag: 'fab5', // <- dale un tag único
                      child: const Icon(Icons.play_arrow),
                      onPressed: () =>
                          context.read<TimerBloc>().add(const TimerRunResumedEvent()),
                    ),
                  ),

                  FadeInLeft(
                    duration: Duration(milliseconds: 200),
                    child: FloatingActionButton(
                      heroTag: 'fab6', // <- dale un tag único
                        child: const Icon(Icons.cancel_rounded),
                        onPressed: () { 
                          context.read<TimerBloc>().add(const TimerRunPausedEvent());
                          openDialog(context);
                          }
                            // context.read<TimerBloc>().add(const TimerResetEvent()),
                      ),
                  ),
                
                ],

                TimerRestPauseState() => [
                  FadeInRight(
                    duration: Duration(milliseconds: 200),
                    child: FloatingActionButton(
                      heroTag: 'fab7', // <- dale un tag único
                      child: const Icon(Icons.play_arrow),
                      onPressed: () =>
                          context.read<TimerBloc>().add(const TimerRestResumedEvent()),
                    ),
                  ),

                  FadeInLeft(
                    duration: Duration(milliseconds: 200),
                    child: FloatingActionButton(
                      heroTag: 'fab8', // <- dale un tag único
                        child: const Icon(Icons.cancel_rounded),
                        onPressed: () { 
                          context.read<TimerBloc>().add(const TimerRunPausedEvent());
                          openDialog(context);
                          }
                            // context.read<TimerBloc>().add(const TimerResetEvent()),
                      ),
                  ),
                
                ],



              TimerRunCompleteState() => [
                  FloatingActionButton(
                    heroTag: 'fab9', // <- dale un tag único
              backgroundColor: Color(0xFFCE090A),
              child: Icon(Icons.cancel_rounded),
              onPressed: () {
                context.pop();
              },
            )
                ],
              // TODO: Handle this case.
              TimerPreStartPauseState() => [
                  FadeInRight(
                    duration: Duration(milliseconds: 200),
                    child: FloatingActionButton(
                      heroTag: 'fab10', // <- dale un tag único
                      child: const Icon(Icons.play_arrow),
                      onPressed: () =>
                          context.read<TimerBloc>().add(const TimerPreStartResumedEvent()),
                    ),
                  ),

                  FadeInLeft(
                    duration: Duration(milliseconds: 200),
                    child: FloatingActionButton(
                      heroTag: 'fab11', // <- dale un tag único
                        child: const Icon(Icons.cancel_rounded),
                        onPressed: () { 
                          context.read<TimerBloc>().add(const TimerPreStartPausedEvent());
                          openDialog(context);
                          }
                            // context.read<TimerBloc>().add(const TimerResetEvent()),
                      ),
                  ),],
              // TODO: Handle this case.
              TimerPreStartInProgressState() => [
                  FloatingActionButton(
                    heroTag: 'fab12', // <- dale un tag único
                    child: const Icon(Icons.pause),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerPreStartPausedEvent()),
                  ),],
              // TODO: Handle this case.
              TimerStartState() => [FloatingActionButton(
                heroTag: 'fab13', // <- dale un tag único
                    child: const Icon(Icons.pause),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerRestPausedEvent()),
                  )],
            }
          ],
        );
      },
    );
  }
}