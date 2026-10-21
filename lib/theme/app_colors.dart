import 'package:flutter/material.dart';

/// Paleta de CWE que se tomo de los mockups (Figura 5) y del logotipo (Figura 6).
/// el color se cambia aquí y se actualiza en toda la app.
class AppColors {
  static const background = Color(0xFF0A0E17);
  static const surface = Color(0xFF161B22);
  static const border = Color(0xFF30363D);

  // --- Acento del COMPRADOR (azul neón: la ciudad / la tecnología) ---
  static const cyan = Color(0xFF00F0FF);
  static const blue = Color(0xFF0077FF);
  static const fresh = Color(0xFF69F0AE);

  // --- Acento del VENDEDOR (verde neón: el campo / la tierra) ---
  static const greenNeon = Color(0xFF39FF4B); // verde neón principal
  static const greenDark = Color(0xFF00B33C); // verde más oscuro para degradados

  // bandera de Colombia que aparece.
  static const flagYellow = Color(0xFFFFD100);
  static const flagBlue = Color(0xFF003893);
  static const flagRed = Color(0xFFCE1126);

  // Degradados de marca por rol.
  static const brandGradient = LinearGradient(colors: [cyan, blue]);
  static const greenGradient = LinearGradient(colors: [greenNeon, greenDark]);
}
