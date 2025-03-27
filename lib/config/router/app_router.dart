
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/pre_round',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name ,
      builder: (context, state) => const HomeScreen(),
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