import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:training_mma_timer/config/router/app_router.dart';
import 'package:training_mma_timer/config/theme/app_theme.dart';

import 'package:training_mma_timer/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:training_mma_timer/presentation/cubit/timer_cubit/timer_cubit.dart';

void main() {
  // Initialize port for communication between TaskHandler and UI.
  FlutterForegroundTask.initCommunicationPort();
  
  runApp(MultiBlocProvider(
    providers: [
        BlocProvider<TimerCubit>(create: (_) => TimerCubit()),
        BlocProvider<SettingsCubit>(create: (_) => SettingsCubit(isSound: true,
                                                                isAlert: true,
                                                                isVibration: true,
                                                                isRotation: false)),
      ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Flutter Demo',
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
