import 'package:flutter/material.dart';
import '../models/finca.dart';
import '../theme/app_colors.dart';

// Formulario para editar la información de la finca del productor.
// Devuelve una Finca con los datos nuevos al pulsar "Guardar".
// Usa el verde del vendedor como color de acento.

class EditFincaScreen extends StatefulWidget {
  final Finca finca;
  final Color accent;
  final bool esOnboarding; // true = primera vez tras registrarse (muestra "Omitir")

  const EditFincaScreen({
    super.key,
    required this.finca,
    this.accent = AppColors.greenNeon,
    this.esOnboarding = false,
  });

  @override
  State<EditFincaScreen> createState() => _EditFincaScreenState();
}

class _EditFincaScreenState extends State<EditFincaScreen> {
  late final TextEditingController _productor;
  late final TextEditingController _nombreFinca;
  late final TextEditingController _ubicacion;
  late final TextEditingController _contacto;
  late final TextEditingController _queCultivo;

  @override
  void initState() {
    super.initState();
    _productor = TextEditingController(text: widget.finca.productor);
    _nombreFinca = TextEditingController(text: widget.finca.nombreFinca);
    _ubicacion = TextEditingController(text: widget.finca.ubicacion);
    _contacto = TextEditingController(text: widget.finca.contacto);
    _queCultivo = TextEditingController(text: widget.finca.queCultivo);
  }

  @override
  void dispose() {
    _productor.dispose();
    _nombreFinca.dispose();
    _ubicacion.dispose();
    _contacto.dispose();
    _queCultivo.dispose();
    super.dispose();
  }

  void _guardar() {
    final actualizada = widget.finca.copyWith(
      productor: _productor.text.trim(),
      nombreFinca: _nombreFinca.text.trim(),
      ubicacion: _ubicacion.text.trim(),
      contacto: _contacto.text.trim(),
      queCultivo: _queCultivo.text.trim(),
    );
    Navigator.pop(context, actualizada); // devuelve los datos nuevos
  }

  InputDecoration _decoration(String label, IconData icon, {String? hint}) {
    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
      labelStyle: const TextStyle(color: Colors.white60),
      filled: true,
      fillColor: AppColors.surface,
      enabledBorder: border(AppColors.border),
      focusedBorder: border(widget.accent, 2),
      prefixIcon: Icon(icon, color: widget.accent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Mi lugar de cultivo'),
        iconTheme: const IconThemeData(color: Colors.white),
        // En el onboarding no mostramos flecha de volver (se usa "Omitir").
        automaticallyImplyLeading: !widget.esOnboarding,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Cuéntale a la ciudad sobre tu lugar de cultivo ',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _productor,
                style: const TextStyle(color: Colors.white),
                decoration: _decoration('Productor', Icons.person_outline,
                    hint: 'Tu nombre'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _nombreFinca,
                style: const TextStyle(color: Colors.white),
                decoration: _decoration('Nombre del lugar', Icons.agriculture_outlined,
                    hint: 'Ej: Finca La Esperanza, Huerta El Rosal'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _ubicacion,
                style: const TextStyle(color: Colors.white),
                decoration: _decoration('Vereda / Municipio', Icons.location_on_outlined,
                    hint: 'Ej: Vereda El Salitre, Fómeque'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _contacto,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: _decoration('Contacto', Icons.phone_outlined,
                    hint: 'Teléfono / WhatsApp'),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _queCultivo,
                maxLines: 2,
                style: const TextStyle(color: Colors.white),
                decoration: _decoration('Qué cultivo', Icons.spa_outlined,
                    hint: 'Ej: Frutas de clima frío, cosecha propia'),
              ),
              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.accent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _guardar,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Guardar cambios',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Solo en el onboarding: permite llenar los datos más tarde.
              if (widget.esOnboarding) ...[
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context), // sin guardar
                  child: const Text(
                    'Omitir por ahora',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
