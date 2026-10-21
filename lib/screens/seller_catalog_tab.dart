import 'package:flutter/material.dart';
import '../data/products_data.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/role_theme.dart';
import '../widgets/product_card.dart';

// Pestaña "Mi Catálogo" (solo para VENDEDOR / productor).
// El vendedor arma su propio catálogo seleccionando, de los productos que ya
// existen, los que él ofrece a la venta. Por ahora se guarda solo en memoria
// (mientras usa la app); más adelante se guardará en el backend.

class SellerCatalogTab extends StatefulWidget {
  final String userName;
  final Set<Product> misProductos; // estado compartido con la pantalla padre
  final RoleTheme theme;
  final void Function(Product) onToggle;

  const SellerCatalogTab({
    super.key,
    required this.userName,
    required this.misProductos,
    required this.theme,
    required this.onToggle,
  });

  @override
  State<SellerCatalogTab> createState() => _SellerCatalogTabState();
}

class _SellerCatalogTabState extends State<SellerCatalogTab> {
  String _category = 'Todas';

  List<Product> get _filtered {
    return sampleProducts.where((p) {
      return _category == 'Todas' ||
          normalizeText(p.category) == normalizeText(_category);
    }).toList();
  }

  bool _loVendo(Product p) => widget.misProductos.contains(p);

  void _toggle(Product p) {
    final estaba = _loVendo(p);
    widget.onToggle(p);
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(!estaba
            ? '${p.name} agregado a tu catálogo'
            : '${p.name} quitado de tu catálogo'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    final accent = widget.theme.accent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabecera
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Hola, ${widget.userName} 🧑‍🌾',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Arma tu catálogo: marca los productos que vendes.',
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),
              const SizedBox(height: 10),
              // Contador de "mis productos"
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: widget.theme.gradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Vendes ${widget.misProductos.length} producto(s)',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Chips de categoría para filtrar
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final cat = categories[index];
              final selected = _category == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: selected,
                selectedColor: accent,
                backgroundColor: AppColors.surface,
                side: BorderSide(
                  color: selected ? accent : AppColors.border,
                ),
                labelStyle: TextStyle(
                  color: selected ? Colors.black : Colors.white,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
                showCheckmark: false,
                onSelected: (_) => setState(() => _category = cat),
              );
            },
          ),
        ),
        const SizedBox(height: 4),

        // Cuadrícula de productos con botón agregar/quitar
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.72,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final p = items[index];
              return _SellerProductCard(
                product: p,
                selected: _loVendo(p),
                accent: accent,
                onToggle: () => _toggle(p),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Tarjeta de producto para el vendedor: muestra el producto y un botón que
// cambia entre "Agregar" y "Quitar" según si ya lo vende o no.
class _SellerProductCard extends StatelessWidget {
  final Product product;
  final bool selected;
  final Color accent;
  final VoidCallback onToggle;

  const _SellerProductCard({
    required this.product,
    required this.selected,
    required this.accent,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? accent : AppColors.border,
          width: selected ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Marca "Vendiendo" si está seleccionado
            if (selected)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '✓ Vendiendo',
                  style: TextStyle(color: accent, fontSize: 10),
                ),
              )
            else
              const SizedBox(height: 16),
            const SizedBox(height: 4),
            Expanded(child: ProductImage(product: product)),
            const SizedBox(height: 6),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              product.priceLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: accent, fontSize: 11),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selected ? Colors.red.shade400 : accent,
                  foregroundColor: selected ? Colors.white : Colors.black,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onToggle,
                child: Text(
                  selected ? 'Quitar' : 'Agregar',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
