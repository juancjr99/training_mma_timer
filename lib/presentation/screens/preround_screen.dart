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
      body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 297,
                  decoration: BoxDecoration(
                    color: Colors.black,

                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.sports_mma_outlined,size: 60,),),
                Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('5:00',style: TextStyle(fontSize: 40, color: Colors.white),),
                  Text('ROUND TIME',style: TextStyle(fontSize: 20, color: Colors.white),),
                  
                  ],),

                OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: (){},
                child: const Icon(Icons.add,color: Colors.white,),
                ),
                
                OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: (){},
                child: const Icon(Icons.remove,color: Colors.white,),
                ),

              ],
            ),
            Container(height: 1,color: Colors.red,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 297,
                  decoration: BoxDecoration(
                    color: Color(0xFF242529),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 297,
                  decoration: BoxDecoration(
                  color: Color(0xFF242529),

                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Center(
              child:  OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: (){},
                child: const Text("START", style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
    );
  }
}

