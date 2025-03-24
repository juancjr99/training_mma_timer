// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:training_mma_timer/config/helpers/ticker.dart';
import 'package:training_mma_timer/presentation/bloc/timer_bloc.dart';
import 'package:training_mma_timer/presentation/screens/widgets/timer_actions.dart';

import 'widgets/widgets.dart';

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
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Container(
                  width: 297,
                  height: 283,
                  decoration: const BoxDecoration(
                    // gradient: LinearGradient(
                    //   colors: [Color(0xFF171617), Color(0x1A1A1C)],
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    // ),
                    color: Color(0xFF242529),
                  ),
                  child: Column(
                    children: [
                      Container(height: 135, child: Center(child: TimerText())),

                      Container(
                          height: 87,
                          child: Center(
                              child: RoundCardsContainer())),
                      // Center(child: Current_Round()),
                      // Center(child: TimerText()),
                    ],
                  ),
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

// class Current_Round extends StatelessWidget {
//   const Current_Round({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final rounds = context.select((TimerBloc bloc) => bloc.state.rounds);
//     final currentRounds =
//         context.select((TimerBloc bloc) => bloc.state.currentRounds);

//     return BlocBuilder<TimerBloc, TimerState>(
//       buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
//       builder: (context, state) {
//         return switch (state) {
//           TimerInitial() => Text("Let's get started!",
//               style: Theme.of(context).textTheme.headlineLarge),
//           TimerRunPause() => Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Paused',
//                   style: Theme.of(context).textTheme.headlineLarge),

//               Text('$currentRounds/$rounds',
//                   style: Theme.of(context).textTheme.headlineLarge),
//             ],
//           ),
//           TimerRestPause() => Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Paused',
//                   style: Theme.of(context).textTheme.headlineLarge),

//               Text('Rest Time', style: Theme.of(context).textTheme.headlineLarge),
//             ],
//           ),
//           TimerRunInProgress() => Text('$currentRounds/$rounds',
//               style: Theme.of(context).textTheme.headlineLarge),
//           TimerRestInProgress() =>
//             Text('Rest Time', style: Theme.of(context).textTheme.headlineLarge),
//           TimerRunComplete() => Text('You made it!!!',
//               style: Theme.of(context).textTheme.headlineLarge),
//           _ => const SizedBox.shrink(),
//         };
//       },
//     );
//   }
// }

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final restTime = context.select((TimerBloc bloc) => bloc.state.restTime);

    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return FadeInDown(
          duration: Duration(milliseconds: 500),
          child: switch (state) {
            TimerInitialState() => Text(
                '${_toMinutesStr(duration)}:${_toSecondsStr(duration)}',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 95)),
            TimerRunInProgressState() => Text(
                '${_toMinutesStr(duration)}:${_toSecondsStr(duration)}',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 95)),
            TimerRestInProgressState() => Text(
                '${_toMinutesStr(restTime)}:${_toSecondsStr(restTime)}',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 95),
              ),
            TimerRunCompleteState() => const SizedBox.shrink(),
            TimerRunPauseState() => Text(
                '${_toMinutesStr(duration)}:${_toSecondsStr(duration)}',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 95),
              ),
              TimerRestPauseState() => Text(
                '${_toMinutesStr(restTime)}:${_toSecondsStr(restTime)}',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 95),
              ),
            _ => const SizedBox.shrink(),
          },
        );
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

class RoundCardsContainer extends StatelessWidget {
  const RoundCardsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) =>
          prev.runtimeType != state.runtimeType ,
      builder: (context, state) {
        final rounds = context.select((TimerBloc bloc) => bloc.state.rounds);
        final currentRound =
            context.select((TimerBloc bloc) => bloc.state.currentRounds);
        return switch (state) {
          // TODO: Handle this case.
          TimerInitialState() =>
            RoundCards(currentRound: currentRound, rounds: rounds),
          // TODO: Handle this case.
          TimerRunPauseState() => RestCard(currentRound: currentRound, rounds: rounds, text: 'PAUSED',),
          // TODO: Handle this case.
          TimerRestPauseState() =>  RestCard(currentRound: currentRound, rounds: rounds, text: ' REST TIME PAUSED',),
          // TODO: Handle this case.
          TimerRunInProgressState() => RoundCards(currentRound: currentRound, rounds: rounds),
          // TODO: Handle this case.
          TimerRestInProgressState() => RestCard(currentRound: currentRound, rounds: rounds, text: 'REST TIME'),
          // TODO: Handle this case.
          TimerRunCompleteState() => RoundCards(currentRound: currentRound, rounds: rounds),
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
              duration:
                  Duration(milliseconds: 500 + (index * 100)), // Escalonado

              child: ValueListenableBuilder<bool>(
                  valueListenable: startSizeAnimation,
                  builder: (context, shouldAnimate, child) {
                    return TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                            begin: 18,
                            end: shouldAnimate
                                ? (isCurrent ? 54 : 18)
                                : 18), // Agranda solo después del delay
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
                                    : null // Sin gradiente si no es el actual
                                ),
                            child: FutureBuilder(
                                future: Future.delayed(Duration(
                                    milliseconds:
                                        300)), // Espera 1 segundo antes de mostrar el texto
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return TweenAnimationBuilder<double>(
                                        tween:
                                            Tween<double>(begin: 0.0, end: 1.0),
                                        duration: Duration(
                                            milliseconds:
                                                500), // Desvanecimiento suave
                                        builder: (context, opacity, child) {
                                          return AnimatedOpacity(
                                              opacity: shouldAnimate &&
                                                      isCurrent
                                                  ? opacity
                                                  : 0.0, // Aparece solo cuando está animado
                                              duration: const Duration(
                                                  milliseconds:
                                                      50), // Suaviza la aparición del texto
                                              child: isCurrent
                                                  ? Center(
                                                      child: Text(
                                                        'R$currentRound',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineSmall
                                                            ?.copyWith(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black,
                                                                    
                                                                    ),
                                                      ),
                                                    )
                                                  : null); // Solo el actual tiene texto
                                        });
                                  } else {
                                    return SizedBox
                                        .shrink(); // Mientras espera, no muestra nada
                                  }
                                }), // Solo el actual tiene texto
                          );
                        });
                  }));
        }));
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
        children: [ FadeInDown(
          duration:
                  Duration(milliseconds: 500), // Escalonado

          child: Column(
            children: [
              Container(
                key: ValueKey(currentRound),
                width: 54,
                height: 41,
                margin: const EdgeInsets.symmetric(horizontal: 6.5),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFD2AF4A),
                                          Color(0xFFD3AD4B)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      )
                                ),
                child: Center(
                                                          child: Text(
                                                            'R$currentRound',
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .headlineSmall
                                                                ?.copyWith(
                                                                    fontSize: 20,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),                
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                key: ValueKey(text),
                width: 200,
                height: 41,
                margin: const EdgeInsets.symmetric(horizontal: 6.5),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFFD2AF4A),
                                              Color(0xFFD3AD4B)
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          )
                                    ),
                                    child: Center(
                                                          child: Text(
                                                            '$text',
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .headlineSmall
                                                                ?.copyWith(
                                                                    fontSize: 20,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
              ),
            ],
          ))]
        );
  }
}
