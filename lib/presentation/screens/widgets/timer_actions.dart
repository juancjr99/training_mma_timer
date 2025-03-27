import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_mma_timer/presentation/bloc/timer_bloc.dart';

class TimerActions extends StatelessWidget {
  const TimerActions({super.key});

  void openDialog(BuildContext context){
    final timerBloc = context.read<TimerBloc>(); // Guarda el Bloc antes de abrir el diálogo

    showDialog(context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
        title: const Text('Estas seguro?'),
        content: const Text('Desea detener el entrenamiento?'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('No, Continuar', style: TextStyle(color: Colors.white),)),
        
          FilledButton(
            onPressed: (){ 
              timerBloc.add(TimerResetEvent());
              context.pop();
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitialState() => [
                  FloatingActionButton(

                    child: const Icon(Icons.play_arrow),
                    onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStartedEvent(duration: 10, rounds: 5, restTime: 5)),
                  ),


                ],
              TimerRunInProgressState() => [
                  FloatingActionButton(
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
                      child: const Icon(Icons.play_arrow),
                      onPressed: () =>
                          context.read<TimerBloc>().add(const TimerRunResumedEvent()),
                    ),
                  ),

                  FadeInLeft(
                    duration: Duration(milliseconds: 200),
                    child: FloatingActionButton(
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
                      child: const Icon(Icons.play_arrow),
                      onPressed: () =>
                          context.read<TimerBloc>().add(const TimerRestResumedEvent()),
                    ),
                  ),

                  FadeInLeft(
                    duration: Duration(milliseconds: 200),
                    child: FloatingActionButton(
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
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerResetEvent()),
                  ),
                ],
            }
          ],
        );
      },
    );
  }
}