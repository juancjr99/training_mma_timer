// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_mma_timer/config/helpers/ticker.dart';

import 'package:training_mma_timer/config/helpers/timer_format.dart';
import 'package:training_mma_timer/presentation/bloc/timer_bloc.dart';
import 'package:training_mma_timer/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:training_mma_timer/presentation/cubit/timer_cubit/timer_cubit.dart';
import 'package:training_mma_timer/presentation/screens/widgets/timer_actions.dart';

import 'widgets/widgets.dart';

class TimerScreen extends StatelessWidget {
  static const name = 'Timer Screen';
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timerCubit = context.read<TimerCubit>();
    final settingsCubit = context.read<SettingsCubit>();

    return BlocProvider(
      create: (_) => TimerBloc(
        ticker: Ticker(),
        isSound: settingsCubit.state.isSound,
        isAlert: settingsCubit.state.isAlert,
        isRotation: settingsCubit.state.isRotation,
        isVibration: settingsCubit.state.isVibration,
        duration: timerCubit.state.duration,
        rounds: timerCubit.state.rounds,
        restTime: timerCubit.state.restTime,
      ),
      child: TimerView(timerCubit: timerCubit),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({Key? key, required this.timerCubit}) : super(key: key);
  final TimerCubit timerCubit;

  @override
  Widget build(BuildContext context) {
    context.read<TimerBloc>().add(
          TimerPreStartedEvent(
            duration: timerCubit.state.duration,
            rounds: timerCubit.state.rounds,
            restTime: timerCubit.state.restTime,
          ),
        );
    
    void openDialog(BuildContext context){
    final timerBloc = context.read<TimerBloc>(); // Guarda el Bloc antes de abrir el diálogo
    final state = timerBloc.state.runtimeType;
    print('*********************************************$state****************************************************************'); 
    if(state == TimerRunInProgressState){
      context.read<TimerBloc>().add(const TimerRunPausedEvent());
      print('TimerRunPausedEvent');
    } else if(state == TimerRestInProgressState){
      context.read<TimerBloc>().add(const TimerRestPausedEvent());
      print('TimerRestPausedEvent');
    }else if(state == TimerPreStartInProgressState){
      context.read<TimerBloc>().add(const TimerPreStartPausedEvent());
      print('TimerPreStartPausedEvent');
    }else if(state == TimerRunCompleteState){
      context.pop();
      return;
    }



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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Timer'),
        leading: IconButton
        (onPressed: (){
          openDialog(context);
        },
        icon: Icon(Icons.arrow_back)
        ),
        ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  surfaceTintColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        const SizedBox(height: 135, child: Center(child: TimerText())),
                        const SizedBox(height: 20),
                        const SizedBox(height: 87, child: Center(child: RoundCardsContainer())),
                      ],
                    ),
                  ),
                ),
              ),
              TimerActions(timerCubit: timerCubit),
            ],
          ),
        ],
      ),
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


        String getFormattedTime() {
          if (state is TimerRestInProgressState || state is TimerRestPauseState) {
            return '${toMinutesStr(restTime)}:${toSecondsStr(restTime)}';
          }
          if (state is TimerRunCompleteState) {
            return 'FIN';
          }
          return '${toMinutesStr(duration)}:${toSecondsStr(duration)}';
        }

        return FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Text(
            getFormattedTime(),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 95),
          ),
        );
      },
    );
  }
}


class RoundCardsContainer extends StatelessWidget {
  const RoundCardsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType ,
      builder: (context, state) {
        final rounds = context.select((TimerBloc bloc) => bloc.state.rounds);
        final currentRound =
            context.select((TimerBloc bloc) => bloc.state.currentRounds);
        return switch (state) {
          
          TimerInitialState() =>
            RoundCards(currentRound: currentRound, rounds: rounds),
          
          TimerRunPauseState() => RestCard(
              currentRound: currentRound,
              rounds: rounds,
              text: 'PAUSED',
            ),
  
          TimerRestPauseState() => RestCard(
              currentRound: currentRound,
              rounds: rounds,
              text: ' REST TIME PAUSED',
            ),

          TimerRunInProgressState() =>
            RoundCards(currentRound: currentRound, rounds: rounds),
         
          TimerRestInProgressState() => RestCard(
              currentRound: currentRound, rounds: rounds, text: 'REST TIME'),
          
          TimerRunCompleteState() =>
            RoundCards(currentRound: currentRound, rounds: rounds),
          
          TimerPreStartPauseState() =>  Poster(text: 'Paused',timeDelay: 0,),
       
          TimerPreStartInProgressState() => Poster(text: 'Get Ready', timeDelay: 600,),
          
          TimerStartState() =>  Poster(text: 'Get Ready',timeDelay: 0),
        };
      },
    );
  }
}

class RoundCards extends StatelessWidget {
  const RoundCards({
    super.key,
    required this.currentRound,
    required this.rounds,
  });

  final int currentRound;
  final int rounds;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: ValueKey(currentRound),
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(rounds, (index) {
        final isCurrent = index + 1 == currentRound; // Si es el round actual

        final ValueNotifier<bool> startSizeAnimation = ValueNotifier(false);

        // Retrasamos solo el cambio de tamaño (sin afectar la animación de caída)
        Future.delayed(const Duration(milliseconds: 600), () {
          startSizeAnimation.value = true;
        });

        return FadeInDown(
          duration: Duration(milliseconds: 500 + (index * 100)), // Escalonado
          child: ValueListenableBuilder<bool>(
            valueListenable: startSizeAnimation,
            builder: (context, shouldAnimate, child) {
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 18,
                  end: shouldAnimate
                      ? (isCurrent ? 54 : 18)
                      : 18, // Agranda solo después del delay
                ),
                duration: const Duration(
                  milliseconds: 200,
                ),
                builder: (context, size, child) {
                  return Container(
                    width: size,
                    height: 41,
                    margin: const EdgeInsets.symmetric(horizontal: 6.5),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? Color(0xFFD2AF4A)
                          : Color(0xFF63625E), // Destacado o gris
                      gradient: isCurrent
                          ? const LinearGradient(
                              colors: [
                                Color(0xFFD2AF4A),
                                Color(0xFFD3AD4B)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null, // Sin gradiente si no es el actual
                      borderRadius: BorderRadius.circular(10), // Bordes redondeados
                    ),
                    child: FutureBuilder(
                      future: Future.delayed(Duration(
                          milliseconds: 100)), // Espera 100ms antes de mostrar el texto
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            duration: Duration(milliseconds: 100), // Desvanecimiento suave
                            builder: (context, opacity, child) {
                              return AnimatedOpacity(
                                opacity: shouldAnimate && isCurrent
                                    ? opacity
                                    : 0.0, // Aparece solo cuando está animado
                                duration: const Duration(milliseconds: 50), // Suaviza la aparición del texto
                                child: isCurrent
                                    ? Center(
                                        child: Text(
                                          'R$currentRound',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                fontSize: 20,
                                                color: Colors.black,
                                              ),
                                        ),
                                      )
                                    : null, // Solo el actual tiene texto
                              );
                            });
                        } else {
                          return SizedBox.shrink(); // Mientras espera, no muestra nada
                        }
                      },
                    ), // Solo el actual tiene texto
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}



class RestCard extends StatelessWidget {
  const RestCard({
    Key? key,
    required this.currentRound,
    required this.rounds,
    required this.text,
  }) : super(key: key);

  final int currentRound;
  final int rounds;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: ValueKey(currentRound),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 54,
          height: 41,
          margin: const EdgeInsets.symmetric(horizontal: 6.5),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD2AF4A), Color(0xFFD3AD4B)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'R$currentRound',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 5),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 200,
          height: 41,
          margin: const EdgeInsets.symmetric(horizontal: 6.5),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD2AF4A), Color(0xFFD3AD4B)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}

class Poster extends StatelessWidget {
  const Poster({
    super.key,
    required this.text,
    required this.timeDelay,
  });
  final int timeDelay;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> startSizeAnimation = ValueNotifier(false);

    // Retrasamos solo el cambio de tamaño (sin afectar la animación de caída)
    Future.delayed(Duration(milliseconds: timeDelay), () {
      startSizeAnimation.value = true;
    });

    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: ValueListenableBuilder<bool>(
        valueListenable: startSizeAnimation,
        builder: (context, shouldAnimate, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: shouldAnimate ? 250 : 18,
            height: 41,
            margin: const EdgeInsets.symmetric(horizontal: 6.5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFD2AF4A), Color(0xFFD3AD4B)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: AnimatedOpacity(
                opacity: shouldAnimate ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

