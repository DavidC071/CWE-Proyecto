import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../widgets/cwe_logo.dart';

// Pantalla de Registro la cual crea un usuario nuevo en la base de datos a través
// del backend, al terminar, vuelve al login para que el usuario inicie sesión.

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String _tipo = 'consumidor'; // 'consumidor' (comprador) o 'productor' (vendedor)

  String? _nombreError;
  String? _emailError;
  String? _passError;

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _registrar() async {
    final nombre = _nombreController.text.trim();
    final email = _emailController.text.trim();
    final pass = _passController.text;

    setState(() {
      _nombreError = nombre.isEmpty ? 'Ingresa tu nombre' : null;
      _emailError = !email.contains('@') ? 'Ingresa un correo válido' : null;
      _passError = pass.length < 4 ? 'Mínimo 4 caracteres' : null;
    });
    if (_nombreError != null || _emailError != null || _passError != null) {
      return;
    }

    setState(() => _loading = true);
    try {
      await ApiService.registrar(
        nombre: nombre,
        email: email,
        password: pass,
        tipoUsuario: _tipo,
      );
      if (!mounted) return;
      // Avisa y regresa al login.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Cuenta creada! Ahora inicia sesión.'),
          backgroundColor: AppColors.fresh,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.pop(context);
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.mensaje),
          backgroundColor: Colors.red.shade800,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo del registro, fundido con el fondo oscuro.
                  const BrandLogo(
                    asset: 'assets/images/logo_registro.png',
                    height: 150,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Crear cuenta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextField(
                    controller: _nombreController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: Colors.white),
                    decoration: _decoration(
                      label: 'Nombre',
                      icon: Icons.person_outline,
                      errorText: _nombreError,
                    ),
                  ),
                  const SizedBox(height: 18),

                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: Colors.white),
                    decoration: _decoration(
                      label: 'Correo electrónico',
                      icon: Icons.email_outlined,
                      errorText: _emailError,
                    ),
                  ),
                  const SizedBox(height: 18),

                  TextField(
                    controller: _passController,
                    obscureText: _obscure,
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
                  const SizedBox(height: 18),

                  // Tipo de cuenta (comprador o vendedor).
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Tipo de cuenta',
                        style: TextStyle(color: Colors.white60, fontSize: 13)),
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                        value: 'consumidor',
                        label: Text('Comprador'),
                        icon: Icon(Icons.shopping_bag_outlined),
                      ),
                      ButtonSegment(
                        value: 'productor',
                        label: Text('Vendedor'),
                        icon: Icon(Icons.agriculture_outlined),
                      ),
                    ],
                    selected: {_tipo},
                    onSelectionChanged: (s) => setState(() => _tipo = s.first),
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.resolveWith(
                        (states) => states.contains(WidgetState.selected)
                            ? Colors.black
                            : Colors.white,
                      ),
                      backgroundColor: WidgetStateProperty.resolveWith(
                        (states) => states.contains(WidgetState.selected)
                            ? AppColors.cyan
                            : AppColors.surface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

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
                      onPressed: _loading ? null : _registrar,
                      child: _loading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text(
                              'Registrarme',
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
