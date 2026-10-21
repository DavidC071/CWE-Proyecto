import 'package:flutter/material.dart';
import '../models/finca.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/role_theme.dart';
import '../widgets/product_card.dart';

// Panel "Mi Finca" (solo para VENDEDOR / productor).
// Muestra un resumen: saludo, datos de la finca, cuántos productos vende y
// una vista previa de su catálogo, con acceso rápido para editarlo.

class SellerHomeTab extends StatelessWidget {
  final String userName;
  final Set<Product> misProductos;
  final Finca finca;
  final RoleTheme theme;
  final VoidCallback onIrAMiCatalogo;

  const SellerHomeTab({
    super.key,
    required this.userName,
    required this.misProductos,
    required this.finca,
    required this.theme,
    required this.onIrAMiCatalogo,
  });

  @override
  Widget build(BuildContext context) {
    final lista = misProductos.toList();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Header con el banner verde del vendedor.
        _HeaderBannerVerde(asset: theme.headerAsset),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: _contenido(lista),
        ),
      ],
    );
  }

  Widget _contenido(List<Product> lista) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Saludo
        Text(
          'Hola, $userName ',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Bienvenido a tu lugar de cultivo',
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
        const SizedBox(height: 20),

        // Tarjeta con el resumen (cuántos productos vende)
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: theme.gradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.agriculture, color: Colors.black, size: 40),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${misProductos.length}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'productos en tu catálogo',
                      style: TextStyle(color: Colors.black87, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Datos de la finca (se editan desde el Perfil)
        _InfoFinca(finca: finca, accent: theme.accent),
        const SizedBox(height: 20),

        // Vista previa de "Tu catálogo"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tu catálogo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: onIrAMiCatalogo,
              icon: Icon(Icons.edit, size: 16, color: theme.accent),
              label: Text('Editar', style: TextStyle(color: theme.accent)),
            ),
          ],
        ),
        const SizedBox(height: 8),

        if (lista.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                const Icon(Icons.add_business_outlined,
                    size: 40, color: Colors.white38),
                const SizedBox(height: 10),
                const Text(
                  'Aún no vendes productos',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.accent,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: onIrAMiCatalogo,
                  child: const Text('Agregar productos'),
                ),
              ],
            ),
          )
        else
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: lista.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final p = lista[index];
                return _MiniProducto(product: p, accent: theme.accent);
              },
            ),
          ),
      ],
    );
  }
}

// Tarjeta pequeña (horizontal) de un producto que el vendedor ofrece.
class _MiniProducto extends StatelessWidget {
  final Product product;
  final Color accent;
  const _MiniProducto({required this.product, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.6)),
      ),
      child: Column(
        children: [
          Expanded(child: ProductImage(product: product)),
          const SizedBox(height: 6),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            product.priceLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: accent, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

// Datos de la finca (se editan desde el Perfil y se reflejan aquí).
class _InfoFinca extends StatelessWidget {
  final Finca finca;
  final Color accent;
  const _InfoFinca({required this.finca, required this.accent});

  // Muestra el valor o "Sin registrar" si está vacío.
  String _v(String valor) => valor.trim().isEmpty ? 'Sin registrar' : valor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.agriculture_outlined, color: accent, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Mi lugar de cultivo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _fila(Icons.person_outline, 'Productor', _v(finca.productor)),
          _fila(Icons.spa_outlined, 'Nombre del lugar', _v(finca.nombreFinca)),
          _fila(Icons.location_on_outlined, 'Vereda / Municipio',
              _v(finca.ubicacion)),
          _fila(Icons.phone_outlined, 'Contacto', _v(finca.contacto)),
          _fila(Icons.eco_outlined, 'Qué cultivo', _v(finca.queCultivo)),
        ],
      ),
    );
  }

  Widget _fila(IconData icon, String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(width: 10),
          Text('$etiqueta: ',
              style: const TextStyle(color: Colors.white54, fontSize: 13)),
          Expanded(
            child: Text(valor,
                style: const TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

// Header con el banner verde del vendedor. Si falta la imagen, muestra un
// respaldo con el logo y el lema sobre fondo oscuro.
class _HeaderBannerVerde extends StatelessWidget {
  final String asset;
  const _HeaderBannerVerde({required this.asset});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: double.infinity,
      height: 130,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        width: double.infinity,
        height: 120,
        color: AppColors.surface,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CWE',
              style: TextStyle(
                color: AppColors.greenNeon,
                fontSize: 34,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            const Text(
              'Haz que conecten con la tierra',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
