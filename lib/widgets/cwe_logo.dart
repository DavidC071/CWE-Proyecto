import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Texto "CWE" con el degradado de la marca (de respaldo).
class CweLogo extends StatelessWidget {
  final double fontSize;
  final double letterSpacing;

  const CweLogo({super.key, this.fontSize = 26, this.letterSpacing = 2});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => AppColors.brandGradient.createShader(bounds),
      child: Text(
        'CWE',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}

/// Muestra el logo de la marca desde una imagen y lo "funde" con el fondo
/// oscuro usando BlendMode.screen: con este modo, los píxeles negros de la
/// imagen se vuelven invisibles y solo quedan los brillos/colores, así el
/// el logo se integra con el fondo.
///
/// Si la imagen no existe, muestra el texto "CWE" con degradado como respaldo.
class BrandLogo extends StatelessWidget {
  final String asset;
  final double height;
  final double fallbackFontSize;

  const BrandLogo({
    super.key,
    this.asset = 'assets/images/logo_registro.png',
    this.height = 150,
    this.fallbackFontSize = 44,
  });

  @override
  Widget build(BuildContext context) {
    final imagen = Image.asset(
      asset,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          CweLogo(fontSize: fallbackFontSize, letterSpacing: 3),
    );

    // El fondo de la app es casi negro; con screen, el negro del logo se
    // "cancela" contra el fondo y se ve mas estetico.
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        AppColors.background,
        BlendMode.screen,
      ),
      child: imagen,
    );
  }
}
