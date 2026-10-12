import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';

// Pestaña Mis Pedidos: historial de pedidos confirmados en esta sesión.

class OrdersTab extends StatelessWidget {
  final List<Order> orders;

  const OrdersTab({super.key, required this.orders});

  String _date(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.assignment_outlined, size: 56, color: Colors.white38),
            SizedBox(height: 12),
            Text('Aún no tienes pedidos',
                style: TextStyle(color: Colors.white70, fontSize: 16)),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Mis Pedidos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        for (final order in orders)
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pedido #${order.number}',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(_date(order.date),
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(order.lines.join('  •  '),
                    style: const TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 8),
                Text('Total: ${formatCop(order.total)}',
                    style: const TextStyle(
                        color: AppColors.cyan, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
      ],
    );
  }
}
