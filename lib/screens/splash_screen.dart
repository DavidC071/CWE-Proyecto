import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/cwe_logo.dart';
import 'login_screen.dart';

// Pantalla de bienvenida (splash). Aparece unos segundos al abrir la app,
// muestra el logo con una animación suave y luego pasa al login.
// En una esquina discreta muestra los créditos del equipo.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  // Controla el desvanecido de TODO el splash justo antes de navegar.
  double _opacidadSalida = 1.0;

  @override
  void initState() {
    super.initState();

    // Controla la animación de aparición del logo (fade + leve zoom).
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();

    // A los ~2.6s empieza a desvanecerse el splash; luego navega al login.
    Timer(const Duration(milliseconds: 2600), _desvanecerYSalir);
  }

  void _desvanecerYSalir() {
    if (!mounted) return;
    // 1) Desvanece suavemente todo el splash.
    setState(() => _opacidadSalida = 0.0);
    // 2) Cuando termina el desvanecido, navega con una transición fade larga.
    Timer(const Duration(milliseconds: 650), _irAlLogin);
  }

  void _irAlLogin() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 900),
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, animation, __, child) {
          final curva = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
          return FadeTransition(opacity: curva, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // AnimatedOpacity desvanece TODO el splash suavemente antes de salir,
      // evitando el "corte" brusco hacia el login.
      body: AnimatedOpacity(
        opacity: _opacidadSalida,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOut,
        child: Stack(
          children: [
            // Centro: logo + nombre + eslogan, con animación de aparición.
            Center(
            child: FadeTransition(
              opacity: _fade,
              child: ScaleTransition(
                scale: _scale,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo (imagen fundida con el fondo). Si no está, usa el
                    // texto CWE con degradado como respaldo.
                    const BrandLogo(
                      asset: 'assets/images/logo_registro.png',
                      height: 180,
                      fallbackFontSize: 64,
                    ),
                    const SizedBox(height: 10),
                    const CweLogo(fontSize: 40, letterSpacing: 4),
                    const SizedBox(height: 10),
                    const Text(
                      'Conecta con la tierra',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Indicador de carga sutil.
                    SizedBox(
                      width: 26,
                      height: 26,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.cyan.withValues(alpha: 0.8)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Créditos del equipo en la esquina inferior, discretos.
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Column(
              children: const [
                Text(
                  'Desarrollado por',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white38, fontSize: 10),
                ),
                SizedBox(height: 4),
                Text(
                  'Danna Lizeth Rodríguez  ·  David Esteban Carrillo\n'
                  'Farid Leonardo Casas  ·  Sebastián Vizcaíno',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
