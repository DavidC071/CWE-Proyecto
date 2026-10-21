import 'package:flutter/material.dart';
import '../models/finca.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/role_theme.dart';
import 'cart_tab.dart';
import 'edit_finca_screen.dart';
import 'home_tab.dart';
import 'login_screen.dart';
import 'orders_tab.dart';
import 'profile_tab.dart';
import 'seller_catalog_tab.dart';
import 'seller_home_tab.dart';

// Pantalla principal que contiene la barra de navegación inferior.
// Muestra pestañas distintas según el ROL del usuario:
//   • Comprador (consumidor): Inicio · Mercado(carrito) · Mis Pedidos · Perfil
//   • Vendedor (productor):   Mi Tienda · Mi Catálogo · Perfil

class CatalogScreen extends StatefulWidget {
  final String userName;
  final String tipoUsuario; // 'consumidor' o 'productor'

  const CatalogScreen({
    super.key,
    this.userName = 'Usuario',
    this.tipoUsuario = 'consumidor',
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _currentIndex = 0;
  final Map<Product, int> _cart = {};
  final List<Order> _orders = [];

  // Productos que el VENDEDOR marcó como "los que yo vendo" (en memoria).
  final Set<Product> _misProductos = {};

  // Datos de la finca del productor (en memoria por ahora).
  late Finca _finca;

  @override
  void initState() {
    super.initState();
    // El productor arranca con el nombre del registro; lo demás lo completa él.
    _finca = Finca(productor: widget.userName);

    // Si es vendedor, al entrar por primera vez se abre el formulario para que
    // llene los datos de su lugar de cultivo (puede omitirlo).
    if (_esVendedor) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _editarFinca(onboarding: true));
    }
  }

  int get _cartCount => _cart.values.fold(0, (sum, qty) => sum + qty);

  // Abre el formulario de edición y guarda los datos nuevos de la finca.
  // [onboarding] = true cuando es la primera vez (tras registrarse): muestra "Omitir".
  Future<void> _editarFinca({bool onboarding = false}) async {
    final actualizada = await Navigator.push<Finca>(
      context,
      MaterialPageRoute(
        builder: (_) => EditFincaScreen(
          finca: _finca,
          accent: AppColors.greenNeon, // el formulario del vendedor va en verde
          esOnboarding: onboarding,
        ),
      ),
    );
    if (actualizada != null) {
      setState(() => _finca = actualizada);
    }
  }

  void _toggleMiProducto(Product p) {
    setState(() {
      if (_misProductos.contains(p)) {
        _misProductos.remove(p);
      } else {
        _misProductos.add(p);
      }
    });
  }

  // Lleva al vendedor a la pestaña "Mi Catálogo" (índice 1).
  void _irAMiCatalogo() => setState(() => _currentIndex = 1);

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
          total: subtotal + serviceFee(subtotal),
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

  // ¿Es vendedor? (productor). Si no, es comprador (consumidor).
  bool get _esVendedor =>
      widget.tipoUsuario.toLowerCase().startsWith('prod');

  @override
  Widget build(BuildContext context) {
    // Tema de color según el rol: azul (comprador) o verde (vendedor).
    final theme = RoleTheme(_esVendedor);

    // Pestañas y botones según el rol.
    final List<Widget> pages;
    final List<BottomNavigationBarItem> items;

    if (_esVendedor) {
      // VENDEDOR: Mi Finca · Mi Catálogo · Perfil
      pages = <Widget>[
        SellerHomeTab(
          userName: widget.userName,
          misProductos: _misProductos,
          finca: _finca,
          theme: theme,
          onIrAMiCatalogo: _irAMiCatalogo,
        ),
        SellerCatalogTab(
          userName: widget.userName,
          misProductos: _misProductos,
          theme: theme,
          onToggle: _toggleMiProducto,
        ),
        ProfileTab(
          userName: widget.userName,
          tipoUsuario: widget.tipoUsuario,
          theme: theme,
          onLogout: _logout,
          onEditarFinca: _editarFinca,
        ),
      ];
      items = const [
        BottomNavigationBarItem(
          icon: Icon(Icons.agriculture_outlined),
          label: 'Mi Cultivo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_2_outlined),
          label: 'Mi Catálogo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ];
    } else {
      // COMPRADOR: Inicio · Mercado(carrito) · Mis Pedidos · Perfil
      pages = <Widget>[
        HomeTab(onAdd: _addToCart),
        CartTab(cart: _cart, onChangeQty: _changeQty, onConfirm: _confirmOrder),
        OrdersTab(orders: _orders),
        ProfileTab(
          userName: widget.userName,
          tipoUsuario: widget.tipoUsuario,
          theme: theme,
          onLogout: _logout,
        ),
      ];
      items = [
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
      ];
    }

    // Evita que el índice quede fuera de rango al cambiar de rol.
    final safeIndex = _currentIndex.clamp(0, pages.length - 1);

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: safeIndex, children: pages),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: theme.accent,
        unselectedItemColor: Colors.white54,
        currentIndex: safeIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: items,
      ),
    );
  }
}
