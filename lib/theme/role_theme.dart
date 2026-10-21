import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Define los colores de acento según el ROL del usuario:
///   • Comprador (consumidor) → azul/cian neón (la ciudad, la tecnología)
///   • Vendedor  (productor)  → verde neón   (el campo, la tierra)
///
/// Las pantallas piden `accent`, `accentGradient`, etc., y reciben el color
/// correcto sin tener que saber el rol. Así cambiamos todo el tema con una
/// sola fuente de verdad.
class RoleTheme {
  final bool esVendedor;

  const RoleTheme(this.esVendedor);

  /// Crea el tema a partir del tipo de usuario ('consumidor' / 'productor').
  factory RoleTheme.fromTipo(String tipoUsuario) {
    return RoleTheme(tipoUsuario.toLowerCase().startsWith('prod'));
  }

  /// Color de acento principal (botones, bordes, íconos activos, logo).
  Color get accent => esVendedor ? AppColors.greenNeon : AppColors.cyan;

  /// Color secundario para el degradado.
  Color get accentDark => esVendedor ? AppColors.greenDark : AppColors.blue;

  /// Degradado de marca (tarjetas, logo con shader).
  LinearGradient get gradient =>
      esVendedor ? AppColors.greenGradient : AppColors.brandGradient;

  /// Banner del header según el rol.
  String get headerAsset => esVendedor
      ? 'assets/images/header_cwe_verde.png'
      : 'assets/images/header_cwe.png';
}
