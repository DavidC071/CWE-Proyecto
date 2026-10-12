import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Texto "CWE" con el degradado de la marca.
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
