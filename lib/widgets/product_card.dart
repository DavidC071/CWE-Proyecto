import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';

/// Imagen del producto.
/// Orden de respaldo: 1) foto en assets/images  2) ícono png en assets/icons
/// 3) emoji de la categoría. Así la tarjeta nunca se ve vacía o rota.
class ProductImage extends StatelessWidget {
  final Product product;
  final double iconSize;

  const ProductImage({super.key, required this.product, this.iconSize = 42});

  @override
  Widget build(BuildContext context) {
    final emojiFallback = Center(
      child: Text(
        product.categoryEmoji,
        style: TextStyle(fontSize: iconSize),
      ),
    );

    // Intenta el ícono generado por nombre en assets/icons/.
    Widget tryIcon() => Image.asset(
          product.autoIconPath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => emojiFallback,
        );

    // Intenta la foto real en assets/images/.
    final child = product.image == null
        ? tryIcon()
        : Image.asset(
            product.image!,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => tryIcon(),
          );

    return SizedBox.expand(child: child);
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final isSupermarket = product.provider == 'Supermercado';
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    product.tag,
                    style: const TextStyle(color: AppColors.fresh, fontSize: 10),
                  ),
                ),
                InkWell(
                  onTap: onAdd,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: AppColors.cyan,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.black, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Expanded(child: ProductImage(product: product)),
            const SizedBox(height: 6),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              product.priceLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.cyan,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  isSupermarket ? Icons.storefront_outlined : Icons.eco_outlined,
                  size: 13,
                  color: Colors.white54,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    product.provider,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
