import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_mma_timer/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:vibration/vibration.dart';  // Importar el paquete de vibración

class SettingsScreen extends StatelessWidget {
  static const name = 'Settings_screen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return _UiControlsView();
        },
      ),
    );
  }
}

class _UiControlsView extends StatelessWidget {
  const _UiControlsView({super.key});

  static const WidgetStateProperty<Icon> thumbIcon = WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.check,color: Color(0xFFA30808),),
      WidgetState.any: Icon(Icons.close),
    },
  );


  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>();
    final List<Map<String, dynamic>> settingsOptions = [
      {
        'title': 'sound',
        'subtitle': 'sound at the end of the round',
        'value': settings.state.isSound,
        'onChanged': settings.sound,
      },
      {
        'title': 'Vibration',
        'subtitle': 'vibrates at the end of the round',
        'value': settings.state.isVibration,
        'onChanged': settings.vibration,
      },
      // {
      //   'title': 'Rotation',
      //   'value': settings.state.isRotation,
      //   'onChanged': settings.rotation,
      // },
      {
        'title': 'Alerts before round ends',
        'subtitle': 'countdown to the end of the round',
        'value': settings.state.isAlert,
        'onChanged': settings.alert,
      },
    ];
    
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(5, 5 , 5, 7),
      children:settingsOptions.map((settingsOptions) {
    return SwitchListTile(
      value: settingsOptions['value'],
      thumbIcon: thumbIcon,
      onChanged: (value) {
        Function fn = settingsOptions['onChanged'];
        fn(); // Llamar la función del setting
        _vibrate();
      },
      title: Text(
        settingsOptions['title'],
        style: const TextStyle(color: Colors.white),
      ),
      subtitle:  Text(settingsOptions['subtitle'],style: TextStyle(color: Color(0xFF79747E),)) ,

    );
  }).toList(),
    );
  }

   // Función para realizar una vibración leve
  void _vibrate() async{
    if (await Vibration.hasVibrator()) {
      // Realiza una vibración breve y leve (sin una pausa larga)
      Vibration.vibrate(duration: 50);
    }
  }


}


//  [

//           SwitchListTile(
//             value: settings.state.isSound,
//             thumbIcon: thumbIcon,
            
//             onChanged: (value){
//               settings.sound();
//               _vibrate();
//             },
//             title:  const Text('Sound',style: TextStyle(color: Colors.white),),
//             subtitle:  const Text('Additional controls',style: TextStyle(color: Color(0xFF79747E),)  ) ,
//           ),

//           SwitchListTile(
//             value: settings.state.isVibration,
//             thumbIcon: thumbIcon,
//             onChanged: (value){
//               settings.vibration();
//               _vibrate();
//             },
//             title: const Text('Vibration',style: TextStyle(color: Colors.white)),
//             subtitle: const Text('Additional controls',style: TextStyle(color: Color(0xFF79747E),)) ,
//           ),

//           SwitchListTile(
//             value: settings.state.isRotation,
//             thumbIcon: thumbIcon,
//             onChanged: (value){
//               settings.rotation();
//               _vibrate();
//             },
//             title: const Text('Rotation',style: TextStyle(color: Colors.white)),
//             subtitle: const Text('Additional controls',style: TextStyle(color: Color(0xFF79747E), ),) ,
//           ),

//           SwitchListTile(
//             value: settings.state.isAlert,
//             thumbIcon: thumbIcon,
//             onChanged: (value){
//               settings.alert();
//               _vibrate();
//             },
//             title: const Text('Alerts before round ends',style: TextStyle(color: Colors.white)),
//             subtitle: const Text('Additional controls',style: TextStyle(color: Color(0xFF79747E),)) ,
//           ),

        
//       ],
