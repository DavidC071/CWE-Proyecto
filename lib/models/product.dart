/// Producto del catálogo (corresponde a la clase Producto del diagrama de clases).
class Product {
  final String name;
  final int price; // en pesos colombianos
  final String unit;
  final String provider;
  final String category;
  final String tag;
  final String? image; // ruta del asset, por ejemplo assets/images/lulo.png

  const Product({
    required this.name,
    required this.price,
    required this.provider,
    required this.category,
    this.unit = 'kg',
    this.tag = 'Fresco',
    this.image,
  });

  String get priceLabel => '${formatCop(price)} / $unit';

  /// Ruta del asset del ícono emoji/png por nombre, calculada a partir del
  /// nombre del producto. Ej: "Tomate de árbol" -> assets/icons/tomate_de_arbol.png
  /// Se usa como respaldo cuando [image] es null.
  String get autoIconPath => 'assets/icons/${slug(name)}.png';

  /// Emoji representativo según la categoría. Sirve como respaldo visual
  String get categoryEmoji => categoryEmojiFor(category);
}

/// Convierte "Tomate de árbol" en "tomate_de_arbol" (sin tildes ni espacios).
String slug(String input) {
  final normalized = normalizeText(input).trim();
  final buffer = StringBuffer();
  for (final ch in normalized.split('')) {
    if (RegExp(r'[a-z0-9]').hasMatch(ch)) {
      buffer.write(ch);
    } else if (ch == ' ' || ch == '-') {
      buffer.write('_');
    }
  }
  return buffer.toString();
}

/// Emoji por categoría (respaldo cuando no hay imagen del producto).
String categoryEmojiFor(String category) {
  switch (normalizeText(category)) {
    case 'frutas':
      return '🍎';
    case 'verduras':
      return '🥬';
    case 'hortalizas':
      return '🥕';
    case 'tuberculos':
      return '🥔';
    case 'hierbas':
      return '🌿';
    default:
      return '🧺';
  }
}

/// Pedido confirmado por el comprador.
class Order {
  final int number;
  final int total;
  final List<String> lines;
  final DateTime date;

  const Order({
    required this.number,
    required this.total,
    required this.lines,
    required this.date,
  });
}

/// Costo de envío fijo del prototipo.
const int shippingCost = 5000;

/// Convierte 8900 en "$8.900 COP".
String formatCop(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return '\$$buffer COP';
}

/// Minúsculas y sin tildes, para que "maracuya" encuentre "Maracuyá".
String normalizeText(String input) {
  const from = 'áàäâéèëêíìïîóòöôúùüûñ';
  const to = 'aaaaeeeeiiiioooouuuun';
  var out = input.toLowerCase();
  for (var i = 0; i < from.length; i++) {
    out = out.replaceAll(from[i], to[i]);
  }
  return out;
}
