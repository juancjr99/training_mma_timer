
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/example',
  routes: [
    GoRoute(
      path: '/settings',
      name: SettingsScreen.name ,
      builder: (context, state) => const SettingsScreen(),
      ),

      GoRoute(
      path: '/example',
      name: ExamplePage.name ,
      builder: (context, state) => const ExamplePage(),
      ),
    
    GoRoute(
      path: '/timer',
      name: TimerScreen.name ,
      builder: (context, state) => const TimerScreen(),
      ),

    GoRoute(
      path: '/pre_round',
      name: PreRoundScreen.name ,
      builder: (context, state) =>  PreRoundScreen(),
      ),  

  ]
);