import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training_mma_timer/config/helpers/timer_format.dart';
import 'package:training_mma_timer/presentation/cubit/timer_cubit/timer_cubit.dart';
import 'package:training_mma_timer/presentation/screens/widgets/side_menu.dart';

class PreRoundScreen extends StatelessWidget {
  static const name = 'PreRound Screen';

  @override
  Widget build(BuildContext context) {
    final timerBloc = context.read<TimerCubit>();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (_) => timerBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Configurar Entrenamiento"),
          actions: [
            IconButton(
              icon: Icon(Icons.settings_outlined, color: Theme.of(context).colorScheme.primary),
              onPressed: () => context.push('/settings'),
            ),
          ],
        ),
        drawer: SideMenu(scaffoldKey: scaffoldKey,),
        body: BlocBuilder<TimerCubit, TimerCubitState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    'Duración de entrenamiento ${toMinutesStr(state.duration * state.rounds)}:${toSecondsStr(state.duration * state.rounds)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16),
                  SettingsCard(icon: Icons.timer_outlined, text: 'ROUND TIME', value: state.duration, isRound: false),
                  SettingsCard(icon: Icons.hourglass_bottom_outlined, text: 'REST TIME', value: state.restTime, isRound: false),
                  SettingsCard(icon: Icons.sports_mma_outlined, text: 'ROUNDS', value: state.rounds, isRound: true),
                ],
              ),
            );
          },
        ),
        floatingActionButton: BlocBuilder<TimerCubit, TimerCubitState>(
          builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: state.duration == 0 ? Colors.red : Theme.of(context).colorScheme.primary,
              child: Icon(state.duration == 0 ? Icons.cancel_rounded : Icons.play_arrow),
              onPressed: () {
                if (state.duration != 0) {
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

class SettingsCard extends StatelessWidget {
  final int value;
  final IconData icon;
  final String text;
  final bool isRound;

  const SettingsCard({Key? key, required this.icon, required this.text, required this.value, required this.isRound}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Theme.of(context).colorScheme.secondary,
      // color: const Color(0xFF2A2A2F), // Darker background for the card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // shadowColor: const Color(0xFFCE090A), // Red shadow color
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          leading: Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
          title: Text(
            !isRound ? '${toMinutesStr(value)}:${toSecondsStr(value)}' : '$value',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontFamily: 'Sternbach',),
          ),
          subtitle: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => _adjustValue(context, decrement: true),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _adjustValue(context, decrement: false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _adjustValue(BuildContext context, {required bool decrement}) {
    final timerCubit = context.read<TimerCubit>();
    if (isRound) {
      decrement ? timerCubit.decreaseRounds(1) : timerCubit.increaseRounds(1);
    } else if (icon == Icons.timer_outlined) {
      decrement ? timerCubit.decreaseRoundTime(5) : timerCubit.increaseRoundTime(5);
    } else {
      decrement ? timerCubit.decreaseRestTime(5) : timerCubit.increaseRestTime(5);
    }
  }
}
