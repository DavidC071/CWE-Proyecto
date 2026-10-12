import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// Pestaña Perfil: datos básicos y cierre de sesión.

class ProfileTab extends StatelessWidget {
  final String userName;
  final VoidCallback onLogout;

  const ProfileTab({super.key, required this.userName, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.surface,
              child: Icon(Icons.person, size: 48, color: AppColors.cyan),
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
            const Text('Comprador',
                style: TextStyle(color: Colors.white54, fontSize: 13)),
            const SizedBox(height: 32),
            OutlinedButton.icon(
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
