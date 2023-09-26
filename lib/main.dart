import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fruit_fungal_diseases/config/router/app_router.dart';
import 'package:fruit_fungal_diseases/config/theme/app_theme.dart';

void main() async{
  runApp(
    const ProviderScope(child: MainApp())
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
    );
  }
}
