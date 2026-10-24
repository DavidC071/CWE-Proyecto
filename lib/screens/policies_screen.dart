import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Pantalla de Términos y Políticas dentro de la app.
// Muestra un resumen de las políticas de CWE (datos, cookies y respaldo).
// El texto completo está también en la página web del proyecto.

class PoliciesScreen extends StatelessWidget {
  const PoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Términos y Políticas'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            Text(
              'CWE SAS — Conecta con la Tierra',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Última actualización: enero de 2026',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            SizedBox(height: 20),

            _Seccion(
              icono: Icons.privacy_tip_outlined,
              titulo: '1. Tratamiento de datos personales',
              parrafos: [
                'En CWE protegemos tus datos conforme a la Ley 1581 de 2012 de '
                    'Colombia (Habeas Data).',
                'Recolectamos: nombre, correo electrónico, contraseña (de forma '
                    'protegida) y el tipo de cuenta (comprador o productor). Para '
                    'productores, también los datos de su lugar de cultivo.',
                'Usamos esos datos solo para crear tu cuenta, permitir el inicio '
                    'de sesión y conectar a productores con compradores.',
                'Tienes derecho a conocer, actualizar, rectificar y solicitar la '
                    'eliminación de tus datos cuando quieras.',
              ],
            ),

            _Seccion(
              icono: Icons.cookie_outlined,
              titulo: '2. Política de cookies',
              parrafos: [
                'Las cookies son pequeños archivos que recuerdan tus preferencias '
                    'y mejoran tu experiencia. No son virus ni dañan tu dispositivo.',
                'Usamos cookies esenciales (para el funcionamiento), funcionales '
                    '(para personalizar) y de análisis (para mejorar el servicio).',
                'Puedes controlar o eliminar las cookies desde la configuración de '
                    'tu navegador.',
              ],
            ),

            _Seccion(
              icono: Icons.backup_outlined,
              titulo: '3. Política de copias de respaldo',
              parrafos: [
                'Realizamos copias de respaldo automáticas diarias de la base de '
                    'datos, con una retención mínima de 30 días.',
                'La información se guarda de forma protegida y, cuando es sensible, '
                    'se aplica cifrado.',
                'Hacemos pruebas periódicas de restauración para garantizar que la '
                    'información se pueda recuperar ante cualquier incidente.',
              ],
            ),

            SizedBox(height: 10),
            _Contacto(),
            SizedBox(height: 20),
            Text(
              'Puedes consultar el texto completo de estas políticas en nuestra '
                  'página web.',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _Seccion extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final List<String> parrafos;

  const _Seccion({
    required this.icono,
    required this.titulo,
    required this.parrafos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icono, color: AppColors.cyan, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final p in parrafos)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '• $p',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Contacto extends StatelessWidget {
  const _Contacto();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contacto',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text('📍 Bogotá, Colombia', style: TextStyle(color: Colors.black87)),
          Text('📞 +57 305 4661890', style: TextStyle(color: Colors.black87)),
          Text('✉️ contacto@cwe.com', style: TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
