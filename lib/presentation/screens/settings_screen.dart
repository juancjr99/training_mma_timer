import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_mma_timer/presentation/cubit/settings_cubit/settings_cubit.dart';

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

enum Transportation { car, plane, boat, submarine }

class _UiControlsView extends StatelessWidget {
  const _UiControlsView({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>();
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [

        SwitchListTile(
          value: settings.state.isSound,
          onChanged: (value) {
            settings.sound();
          },
          activeTrackColor: Color(0xFFCE090A),
          title: const Text('Sound'),
          subtitle: const Text('Controles adicionales'),
        ),


        Container(
          height: 1,
          color: Color(0xFFCE090A),
        ),
        SwitchListTile(
          value: settings.state.isVibration,
          onChanged: (value) {
            settings.vibration();
          },
          activeTrackColor: Color(0xFFCE090A),
          title: const Text('Vibration'),
          subtitle: const Text('Controles adicionales'),
        ),
        Container(
          height: 1,
          color: Color(0xFFCE090A),
        ),

        SwitchListTile(
          value: settings.state.isRotation,
          onChanged: (value) {
            settings.rotation();
          },
          activeTrackColor: Color(0xFFCE090A),
          title: const Text('Permitir la Rotacion'),
          subtitle: const Text('Controles adicionales'),
        ),
        Container(
          height: 1,
          color: Color(0xFFCE090A),
        ),

        SwitchListTile(
          value: settings.state.isAlert,
          onChanged: (value) {
            settings.alert();
          },
          activeTrackColor: Color(0xFFCE090A),
          title: const Text('Alertas antes del final de la ronda'),
          subtitle: const Text('Controles adicionales'),
        ),
      ],
    );
  }
}

class _UiControlsView1 extends StatefulWidget {
  const _UiControlsView1({
    super.key,
  });

  @override
  State<_UiControlsView1> createState() => _UiControlsView1State();
}

class _UiControlsView1State extends State<_UiControlsView1> {
  bool isSound = true;
  bool isVibration = true;
  bool isRotation = false;
  bool isAlert = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
          value: isSound,
          onChanged: (value) {
            setState(
              () {
                isSound = !isSound;
              },
            );
          },
          activeTrackColor: Color(0xFFCE090A),
          title: const Text('Sound'),
          subtitle: const Text('Controles adicionales'),
        ),
        Container(
          height: 1,
          color: Color(0xFFCE090A),
        ),
        SwitchListTile(
          value: isVibration,
          onChanged: (value) {
            setState(() {
              isVibration = !isVibration;
            });
          },
          activeTrackColor: Color(0xFFCE090A),
          title: const Text('Vibration'),
          subtitle: const Text('Controles adicionales'),
        ),
        Container(
          height: 1,
          color: Color(0xFFCE090A),
        ),
        SwitchListTile(
          value: isRotation,
          onChanged: (value) {
            setState(() {
              isRotation = !isRotation;
            });
          },
          activeTrackColor: Color(0xFFCE090A),
          title: const Text('Permitir la Rotacion'),
          subtitle: const Text('Controles adicionales'),
        ),
        Container(
          height: 1,
          color: Color(0xFFCE090A),
        ),
        SwitchListTile(
          value: isAlert,
          onChanged: (value) {
            setState(() {
              isAlert = !isAlert;
            });
          },
          activeTrackColor: Color(0xFFCE090A),
          title: const Text('Alertas antes del final de la ronda'),
          subtitle: const Text('Controles adicionales'),
        ),
      ],
    );
  }
}
