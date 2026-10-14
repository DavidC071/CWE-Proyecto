import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import 'cart_tab.dart';
import 'home_tab.dart';
import 'login_screen.dart';
import 'orders_tab.dart';
import 'profile_tab.dart';

// Pantalla principal que contiene la barra de navegación inferior y el estado
// del carrito y los pedidos, cada pestaña es un archivo aparte.

class CatalogScreen extends StatefulWidget {
  final String userName;

  const CatalogScreen({super.key, this.userName = 'Usuario'});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _currentIndex = 0;
  final Map<Product, int> _cart = {};
  final List<Order> _orders = [];

  int get _cartCount => _cart.values.fold(0, (sum, qty) => sum + qty);

  void _showMessage(String text) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(content: Text(text), duration: const Duration(seconds: 1)),
    );
  }

  void _addToCart(Product product) {
    setState(() => _cart[product] = (_cart[product] ?? 0) + 1);
    _showMessage('${product.name} agregado al carrito');
  }

  void _changeQty(Product product, int delta) {
    setState(() {
      final qty = (_cart[product] ?? 0) + delta;
      if (qty <= 0) {
        _cart.remove(product);
      } else {
        _cart[product] = qty;
      }
    });
  }

  void _confirmOrder() {
    if (_cart.isEmpty) return;
    var subtotal = 0;
    final lines = <String>[];
    _cart.forEach((product, qty) {
      subtotal += product.price * qty;
      lines.add('$qty × ${product.name}');
    });
    setState(() {
      _orders.insert(
        0,
        Order(
          number: _orders.length + 1,
          total: subtotal + shippingCost,
          lines: lines,
          date: DateTime.now(),
        ),
      );
      _cart.clear();
      _currentIndex = 2; // Mis Pedidos
    });
    _showMessage('Pedido confirmado');
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeTab(onAdd: _addToCart),
      CartTab(cart: _cart, onChangeQty: _changeQty, onConfirm: _confirmOrder),
      OrdersTab(orders: _orders),
      ProfileTab(userName: widget.userName, onLogout: _logout),
    ];

    return Scaffold(
      body: SafeArea(
        // IndexedStack conserva lo escrito en el buscador al cambiar de pestaña.
        child: IndexedStack(index: _currentIndex, children: pages),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.cyan,
        unselectedItemColor: Colors.white54,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: _cartCount > 0,
              backgroundColor: AppColors.cyan,
              textColor: Colors.black,
              label: Text('$_cartCount'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            label: 'Mercado',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Mis Pedidos',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
