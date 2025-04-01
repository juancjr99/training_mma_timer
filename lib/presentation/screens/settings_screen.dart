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

class _UiControlsView extends StatelessWidget {
  const _UiControlsView({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>();
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(5, 5 , 5, 7),
      children: [
        _buildSettingCard(
          context,
          title: 'Sound',
          subtitle: 'Additional controls',
          value: settings.state.isSound,
          onChanged: (value) {
            settings.sound();
          },
        ),
        //_buildSmallDivider(),
        _buildSettingCard(
          context,
          title: 'Vibration',
          subtitle: 'Additional controls',
          value: settings.state.isVibration,
          onChanged: (value) {
            settings.vibration();
          },
        ),
        //_buildSmallDivider(),
        _buildSettingCard(
          context,
          title: 'Allow Rotation',
          subtitle: 'Additional controls',
          value: settings.state.isRotation,
          onChanged: (value) {
            settings.rotation();
          },
        ),
        //_buildSmallDivider(),
        _buildSettingCard(
          context,
          title: 'Alerts before round ends',
          subtitle: 'Additional controls',
          value: settings.state.isAlert,
          onChanged: (value) {
            settings.alert();
          },
        ),
        
      ],
    );
  }

  Widget _buildSettingCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      color: const Color(0xFF2A2A2F), // Darker background for the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Increased border radius
      ),
      elevation: 5, // Subtle shadow
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(10, 5 , 10, 7),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Color(0xFFB0B0B0)),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: const Color(0xFFCE090A),
          activeColor: Colors.white,
          //  inactiveTrackColor: Color(0xFFC4C4C4), // Color for the track when inactive
              inactiveThumbColor: Color(0xFFC4C4C4), // Thumb color when inactive

        ),
      ),
    );
  }

  Widget _buildSmallDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        height: 1,
        color: Color(0xFFCE090A),
        thickness: 1, // A thinner divider
        indent: 40, // Indent to make it shorter
        endIndent: 40, // Indent to make it shorter
      ),
    );
  }
}
