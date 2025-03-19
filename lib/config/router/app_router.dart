
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/timer',
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

    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name ,
    //   builder: (context, state) => const HomeScreen(),
    //   ),  

  ]
);