import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:training_mma_timer/config/router/app_router.dart';
import 'package:training_mma_timer/config/theme/app_theme.dart';
import 'package:training_mma_timer/data/local/local_storage_service.dart';

import 'package:training_mma_timer/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:training_mma_timer/presentation/cubit/timer_cubit/timer_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   // Forzar orientación vertical
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final settingsData = await LocalStorageService.loadSettings();
  final timerData = await LocalStorageService.loadTimer();
  
  // // Initialize port for communication between TaskHandler and UI.
  // FlutterForegroundTask.initCommunicationPort();
  // // Detener el servicio si está corriendo
  // if (await FlutterForegroundTask.isRunningService) {
  //   await FlutterForegroundTask.stopService();
  // }
  
  runApp(MultiBlocProvider(
    providers: [
        BlocProvider<TimerCubit>(create: (_) => TimerCubit( duration: timerData['duration']!,
                                                            rounds: timerData['rounds']!,
                                                            restTime: timerData['restTime']!)),
        BlocProvider<SettingsCubit>(create: (_) => SettingsCubit(isSound: settingsData['isSound']!,
                                                                isAlert: settingsData['isAlert']!,
                                                                isVibration: settingsData['isVibration']!,
                                                                isRotation: settingsData['isRotation']!)),
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
