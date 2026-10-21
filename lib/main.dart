import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'theme/app_colors.dart';

// Arranca la aplicación con el tema oscuro de CWE.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CWE - Conecta con la tierra',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.cyan,
        // Fuente Poppins en toda la app (si los .ttf no están, Flutter usa
        // la fuente por defecto sin romper nada).
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Poppins'),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.cyan,
          secondary: AppColors.cyan,
          surface: AppColors.surface,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
