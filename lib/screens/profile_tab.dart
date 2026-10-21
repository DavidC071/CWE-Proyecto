import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/role_theme.dart';

// Pestaña Perfil, datos básicos y cierre de sesión.

class ProfileTab extends StatelessWidget {
  final String userName;
  final String tipoUsuario; // 'consumidor' o 'productor'
  final RoleTheme theme;
  final VoidCallback onLogout;
  final VoidCallback? onEditarFinca; // solo lo usa el vendedor

  const ProfileTab({
    super.key,
    required this.userName,
    required this.onLogout,
    required this.theme,
    this.tipoUsuario = 'consumidor',
    this.onEditarFinca,
  });

  bool get _esVendedor => tipoUsuario.toLowerCase().startsWith('prod');
  String get _etiquetaRol => _esVendedor ? 'Vendedor' : 'Comprador';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.surface,
              child: Icon(Icons.person, size: 48, color: theme.accent),
            ),
            const SizedBox(height: 16),
            Text(
              userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(_etiquetaRol,
                style: const TextStyle(color: Colors.white54, fontSize: 13)),
            const SizedBox(height: 32),

            // Solo el vendedor puede editar la información de su finca.
            if (_esVendedor && onEditarFinca != null) ...[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.accent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onEditarFinca,
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text(
                    'Editar mi lugar de cultivo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],

            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.accent,
                side: BorderSide(color: theme.accent),
              ),
              onPressed: onLogout,
              icon: const Icon(Icons.logout),
              label: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
