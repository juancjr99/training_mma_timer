// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_mma_timer/config/helpers/timer_format.dart';

import 'package:training_mma_timer/presentation/bloc/timer_bloc.dart';
import 'package:training_mma_timer/presentation/cubit/timer_cubit.dart';

class PreRoundScreen extends StatelessWidget {
  static const name = 'PreRound Scree';

  @override
  Widget build(BuildContext context) {
    // Guarda el Bloc antes de abrir el diálogo
    final timerBloc = context.read<TimerCubit>();
    return BlocProvider(
      create: (_) => timerBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Configurar Entrenamiento"),
          actions: [
            //setting icon
            IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Color(0xFFCE090A),
              ),
              onPressed: () {
                //TODO: Implementar la navegación a la pantalla de configuración
              },
            ),
          ],
        ),
        body: BlocBuilder<TimerCubit, TimerCubitState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  'Duracion de entrenamiento ${toMinutesStr(context.read<TimerCubit>().state.duration * context.read<TimerCubit>().state.rounds)}:${toSecondsStr(context.read<TimerCubit>().state.duration * context.read<TimerCubit>().state.rounds)}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
                Settings(
                  icon: Icons.timer_outlined,
                  text: 'ROUND TIME',
                  value: state.duration,
                  isRound: false,
                ),
                Container(
                  height: 1,
                  width: 300,
                  color: Color(0xFFCE090A),
                ),
                Settings(
                  icon: Icons.hourglass_bottom_outlined,
                  text: 'REST TIME',
                  value: state.restTime,
                  isRound: false,
                ),
                Container(
                  height: 1,
                  width: 300,
                  color: Color(0xFFCE090A),
                ),
                Settings(
                  icon: Icons.sports_mma_outlined,
                  text: 'ROUNDS',
                  value: state.rounds,
                  isRound: true,
                ),
                Container(
                  height: 1,
                  width: 300,
                  color: Color(0xFFCE090A),
                ),
              ],
            );
          },
        ),
        floatingActionButton: BlocBuilder<TimerCubit, TimerCubitState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: context.read<TimerCubit>().state.duration == 0
                  ? Color(0xFFCE090A)
                  : null,
              child: context.read<TimerCubit>().state.duration == 0 
              ? Icon(Icons.cancel_rounded)
              :Icon(Icons.play_arrow),
              onPressed: () {
                if(context.read<TimerCubit>().state.duration != 0){
                  context.push('/timer');
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({
    Key? key,
    required this.icon,
    required this.text,
    required this.value,
    required this.isRound,
  }) : super(key: key);
  final int value;
  final IconData icon;
  final String text;
  final bool isRound;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              icon,
              size: 60,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  !isRound
                      ? '${toMinutesStr(value)}:${toSecondsStr(value)}'
                      : '$value',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 40),
                ),
                Text(
                  '$text',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(10),
              // ),
            ),
            onPressed: () {
              isRound
                  ? context.read<TimerCubit>().increaseRounds(1)
                  : icon == Icons.timer_outlined
                      ? context.read<TimerCubit>().increaseRoundTime(5)
                      : context.read<TimerCubit>().increaseRestTime(5);
            },
            onLongPress: () {
              isRound
                  ? context.read<TimerCubit>().increaseRounds(1)
                  : icon == Icons.timer_outlined
                      ? context.read<TimerCubit>().increaseRoundTime(30)
                      : context.read<TimerCubit>().increaseRestTime(30);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 7,),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(0),
              // ),
            ),
            
            onPressed: () {
              isRound
                  ? context.read<TimerCubit>().decreaseRounds(1)
                  : icon == Icons.timer_outlined
                      ? context.read<TimerCubit>().decreaseRoundTime(5)
                      : context.read<TimerCubit>().decreaseRestTime(5);
            },
            onLongPress: () {
              isRound
                  ? context.read<TimerCubit>().decreaseRounds(1)
                  : icon == Icons.timer_outlined
                      ? context.read<TimerCubit>().decreaseRoundTime(30)
                      : context.read<TimerCubit>().decreaseRestTime(30);
            },
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        
        ],
      ),
    );
  }
}
