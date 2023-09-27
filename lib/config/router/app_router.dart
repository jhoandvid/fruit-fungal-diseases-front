
import 'package:fruit_fungal_diseases/features/auth/presentation/screens/login_screen.dart';
import 'package:fruit_fungal_diseases/features/auth/presentation/screens/register_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/fruits/presentation/screen/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/register', 
    builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
      ),

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      )
  ]
);
