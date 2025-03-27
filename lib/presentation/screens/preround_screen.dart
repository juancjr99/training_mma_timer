// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

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
      appBar: AppBar(title: Text("Configurar Entrenamiento"),
      
      actions: [  //setting icon  
        IconButton(
          icon: Icon(Icons.settings_outlined, color: Color(0xFFCE090A),),
          onPressed: () {
            //TODO: Implementar la navegación a la pantalla de configuración
          },
        ),
      ],),
      body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Center(child: Text('Duracion de entrenamiento 5:00',style: TextStyle(fontSize: 20, color: Colors.white),)),

            Settings(icon: Icons.timer_outlined,text: 'ROUND TIME',),

            Container(
              height: 1,
              width: 300,
              color: Color(0xFFCE090A),
            ),

            // SizedBox(height: 20),
            Settings(icon: Icons.hourglass_bottom_rounded,text: 'REST TIME',),

            Container(
              height: 1,
              width: 300,
              color: Color(0xFFCE090A),
            ),

            // SizedBox(height: 20),
            Settings(icon: Icons.sports_mma_outlined,text: 'ROUNDS',),


          ],
        ),
        floatingActionButton: FloatingActionButton(

                    child: const Icon(Icons.play_arrow),
                    onPressed: (){},
                  ),
    );
  }
}

class Settings extends StatelessWidget {
  const Settings({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
final IconData icon;
final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              IconButton(onPressed: (){}, icon:  Icon(icon,size: 60,),),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('5:00', style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(fontSize: 40),),
                Text('$text',style: TextStyle(fontSize: 15, color: Colors.white),),
                
                ],),
          
              OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: (){},
              child: const Icon(Icons.add,color: Colors.white,),
              ),
              
              OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              onPressed: (){},
              child: const Icon(Icons.remove,color: Colors.white,),
              ),
          
            ],
          ),
    );
  }
}

