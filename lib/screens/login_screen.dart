import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/cwe_logo.dart';
import 'catalog_screen.dart';

// Pantalla de Login. Valida que usuario y contraseña no estén vacíos
// antes de entrar al catálogo (corrección del error E-05).

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscure = true;
  String? _userError;
  String? _passError;

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _login() {
    final user = _userController.text.trim();
    final pass = _passController.text;
    setState(() {
      _userError = user.isEmpty ? 'Ingresa tu usuario o correo' : null;
      _passError = pass.isEmpty ? 'Ingresa tu contraseña' : null;
    });
    if (_userError != null || _passError != null) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => CatalogScreen(userName: user)),
    );
  }

  InputDecoration _decoration({
    required String label,
    required IconData icon,
    String? errorText,
    Widget? suffix,
  }) {
    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white60),
      errorText: errorText,
      filled: true,
      fillColor: AppColors.surface,
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.cyan, 2),
      errorBorder: border(Colors.redAccent),
      focusedErrorBorder: border(Colors.redAccent, 2),
      prefixIcon: Icon(icon, color: AppColors.cyan),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  // Logotipo (Figura 6). Si el archivo aún no existe, no se muestra.
                  Image.asset(
                    'assets/images/logo_cwe.png',
                    height: 120,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                  const CweLogo(fontSize: 56, letterSpacing: 4),
                  const SizedBox(height: 8),
                  const Text(
                    'Conecta con la tierra',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 50),

                  TextField(
                    controller: _userController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: Colors.white),
                    decoration: _decoration(
                      label: 'Usuario o correo electrónico',
                      icon: Icons.person_outline,
                      errorText: _userError,
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _passController,
                    obscureText: _obscure,
                    onSubmitted: (_) => _login(),
                    style: const TextStyle(color: Colors.white),
                    decoration: _decoration(
                      label: 'Contraseña',
                      icon: Icons.lock_outline,
                      errorText: _passError,
                      suffix: IconButton(
                        icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white54,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cyan,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 8,
                        shadowColor: AppColors.cyan.withValues(alpha: 0.5),
                      ),
                      onPressed: _login,
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
