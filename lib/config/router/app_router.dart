import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/config/router/app_router_notifier.dart';
import 'package:fruit_fungal_diseases/features/auth/presentation/providers/auth_provider.dart';
import 'package:fruit_fungal_diseases/features/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:fruit_fungal_diseases/features/auth/presentation/screens/login_screen.dart';
import 'package:fruit_fungal_diseases/features/auth/presentation/screens/register_screen.dart';
import 'package:fruit_fungal_diseases/features/fruits/presentation/screen/fruit_diseases_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/fruits/presentation/screen/home_screen.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
      initialLocation: '/splash',
      refreshListenable: goRouterNotifier,
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const CheckAuthStatusScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
         
        ),
         GoRoute(
            path: '/fruit/diseases/:id',
            builder: (context, state) {
              final fruitDiseasesId = state.pathParameters['id'] ?? 'no_id';
              return FruitDiseasesScreen(fruitDiseasesId: fruitDiseasesId);
            })
          ],
        
      
      redirect: (context, state) {
        final isGoingTo = state.matchedLocation;
        final authStatus = goRouterNotifier.authStatus;

        if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
          return null;
        }

        if (authStatus == AuthStatus.notAutenticated) {
          if (isGoingTo == '/login' || isGoingTo == '/register') return null;
          return '/login';
        }

        if (authStatus == AuthStatus.authenticated) {
          if (isGoingTo == '/login' ||
              isGoingTo == '/register' ||
              isGoingTo == '/splash') return '/';
        }


        return null;
      });
});
