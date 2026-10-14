import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../widgets/product_card.dart';

// Pestaña Mercado (mockup 2 de la Figura 5).

class CartTab extends StatelessWidget {
  final Map<Product, int> cart;
  final void Function(Product product, int delta) onChangeQty;
  final VoidCallback onConfirm;

  const CartTab({
    super.key,
    required this.cart,
    required this.onChangeQty,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 56, color: Colors.white38),
            SizedBox(height: 12),
            Text('Tu carrito está vacío',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
            SizedBox(height: 4),
            Text('Agrega productos desde Inicio con el botón +',
                style: TextStyle(color: Colors.white38, fontSize: 12)),
          ],
        ),
      );
    }

    var subtotal = 0;
    cart.forEach((product, qty) => subtotal += product.price * qty);
    final total = subtotal + shippingCost;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            'Revisar compra',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              for (final entry in cart.entries)
                _CartLine(
                  product: entry.key,
                  qty: entry.value,
                  onChangeQty: onChangeQty,
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: Column(
            children: [
              _SummaryRow(label: 'Subtotal', value: formatCop(subtotal)),
              _SummaryRow(label: 'Envío', value: formatCop(shippingCost)),
              _SummaryRow(
                label: 'Total',
                value: formatCop(total),
                bold: true,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyan,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: onConfirm,
                  child: const Text(
                    'Confirmar compra',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CartLine extends StatelessWidget {
  final Product product;
  final int qty;
  final void Function(Product product, int delta) onChangeQty;

  const _CartLine({
    required this.product,
    required this.qty,
    required this.onChangeQty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: ProductImage(product: product, iconSize: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Text('De: ${product.provider}',
                    style:
                        const TextStyle(color: Colors.white54, fontSize: 12)),
                Row(
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.remove_circle_outline, size: 22),
                      color: AppColors.cyan,
                      onPressed: () => onChangeQty(product, -1),
                    ),
                    Text('$qty',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.add_circle_outline, size: 22),
                      color: AppColors.cyan,
                      onPressed: () => onChangeQty(product, 1),
                    ),
                    Text('× ${product.priceLabel}',
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          Text(
            formatCop(product.price * qty),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: bold ? Colors.white : Colors.white70,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      fontSize: bold ? 16 : 14,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }
}
