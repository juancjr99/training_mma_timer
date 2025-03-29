import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_mma_timer/config/helpers/ticker.dart';
import 'package:training_mma_timer/config/router/app_router.dart';
import 'package:training_mma_timer/config/theme/app_theme.dart';
import 'package:training_mma_timer/presentation/bloc/timer_bloc.dart';
import 'package:training_mma_timer/presentation/cubit/timer_cubit.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
        BlocProvider<TimerCubit>(create: (_) => TimerCubit()),
        // BlocProvider<TimerBloc>(create: (_) => TimerBloc(ticker: Ticker())),
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
