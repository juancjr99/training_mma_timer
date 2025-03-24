import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_mma_timer/presentation/bloc/timer_bloc.dart';

class PreRoundScreen extends StatefulWidget {

  static const name = 'PreRound Scree';
  @override
  _PreRoundScreenState createState() => _PreRoundScreenState();
}

class _PreRoundScreenState extends State<PreRoundScreen> {
  int roundDuration = 300; // 5 minutos en segundos
  int restDuration = 60;   // 1 minuto en segundos
  int totalRounds = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configurar Entrenamiento")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Duración del asalto (segundos)"),
            Slider(
              value: roundDuration.toDouble(),
              min: 30,
              max: 600,
              divisions: 19,
              label: "$roundDuration",
              onChanged: (value) {
                setState(() {
                  roundDuration = value.toInt();
                });
              },
            ),
            Text("Tiempo de descanso (segundos)"),
            Slider(
              value: restDuration.toDouble(),
              min: 10,
              max: 180,
              divisions: 17,
              label: "$restDuration",
              onChanged: (value) {
                setState(() {
                  restDuration = value.toInt();
                });
              },
            ),
            Text("Número de rounds"),
            Slider(
              value: totalRounds.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: "$totalRounds",
              onChanged: (value) {
                setState(() {
                  totalRounds = value.toInt();
                });
              },
            ),
            
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TimerBloc>(context).add(
                    TimerStartedEvent(
                      duration: roundDuration,
                      rounds: totalRounds,
                      restTime: restDuration,
                      
                    ),
                  );
                  Navigator.pushNamed(context, '/timer');
                },
                child: Text("Iniciar Entrenamiento"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


