import '../models/product.dart';

/// Catálogo de ejemplo del prototipo CWE (Conecta con la Tierra).
/// Más adelante esta lista vendrá del backend.
///
/// Para que la FOTO real de un producto aparezca:
///   1. Coloca el archivo en assets/images/ con el nombre indicado en `image`.
///      Ej: assets/images/lulo.png
///   2. Si no agregas la foto, la tarjeta muestra automáticamente el ícono/emoji
///      de la categoría, así que la app nunca se ve rota.
///
/// Categorías disponibles (se usan en el filtro):
///   Frutas · Verduras · Hortalizas · Tubérculos · Hierbas
const List<Product> sampleProducts = [
  // ---------------------------------------------------------------- FRUTAS
  Product(name: 'Lulo', price: 8900, provider: 'Farmáltor', category: 'Frutas', image: 'assets/images/lulo.png'),
  Product(name: 'Maracuyá', price: 8900, provider: 'Farmáltor', category: 'Frutas', image: 'assets/images/maracuya.png'),
  Product(name: 'Aguacate Hass', price: 12900, provider: 'Supermercado', category: 'Frutas', image: 'assets/images/aguacate_hass.png'),
  Product(name: 'Guanábana', price: 9500, provider: 'Farmáltor', category: 'Frutas', image: 'assets/images/guanabana.png'),
  Product(name: 'Tomate de árbol', price: 5400, provider: 'Supermercado', category: 'Frutas', image: 'assets/images/tomate_de_arbol.png'),
  Product(name: 'Plátano', price: 3800, provider: 'Farmáltor', category: 'Frutas', unit: 'un', image: 'assets/images/platano.png'),
  Product(name: 'Mango', price: 4200, provider: 'Campo Fresco', category: 'Frutas', unit: 'un', image: 'assets/images/mango.png'),
  Product(name: 'Papaya', price: 6300, provider: 'Campo Fresco', category: 'Frutas', image: 'assets/images/papaya.png'),
  Product(name: 'Piña', price: 5000, provider: 'Supermercado', category: 'Frutas', unit: 'un', image: 'assets/images/pina.png'),
  Product(name: 'Fresa', price: 11000, provider: 'Campo Fresco', category: 'Frutas', image: 'assets/images/fresa.png'),
  Product(name: 'Mora', price: 7800, provider: 'Farmáltor', category: 'Frutas', image: 'assets/images/mora.png'),
  Product(name: 'Banano', price: 3200, provider: 'Supermercado', category: 'Frutas', image: 'assets/images/banano.png'),
  Product(name: 'Naranja', price: 3500, provider: 'Campo Fresco', category: 'Frutas', image: 'assets/images/naranja.png'),
  Product(name: 'Mandarina', price: 4000, provider: 'Farmáltor', category: 'Frutas', image: 'assets/images/mandarina.png'),
  Product(name: 'Limón Tahití', price: 4500, provider: 'Supermercado', category: 'Frutas', image: 'assets/images/limon_tahiti.png'),
  Product(name: 'Uva Isabella', price: 9800, provider: 'Supermercado', category: 'Frutas', image: 'assets/images/uva_isabella.png'),
  Product(name: 'Manzana', price: 6500, provider: 'Supermercado', category: 'Frutas', image: 'assets/images/manzana.png'),
  Product(name: 'Pera', price: 7200, provider: 'Supermercado', category: 'Frutas', image: 'assets/images/pera.png'),
  Product(name: 'Granadilla', price: 8500, provider: 'Campo Fresco', category: 'Frutas', image: 'assets/images/granadilla.png'),
  Product(name: 'Curuba', price: 6900, provider: 'Farmáltor', category: 'Frutas', image: 'assets/images/curuba.png'),
  Product(name: 'Feijoa', price: 7500, provider: 'Campo Fresco', category: 'Frutas', image: 'assets/images/feijoa.png'),
  Product(name: 'Pitahaya', price: 15900, provider: 'Supermercado', category: 'Frutas', unit: 'un', image: 'assets/images/pitahaya.png'),
  Product(name: 'Guayaba', price: 4300, provider: 'Farmáltor', category: 'Frutas', image: 'assets/images/guayaba.png'),
  Product(name: 'Coco', price: 5500, provider: 'Campo Fresco', category: 'Frutas', unit: 'un', image: 'assets/images/coco.png'),

  // -------------------------------------------------------------- VERDURAS
  Product(name: 'Lechuga', price: 2800, provider: 'Campo Fresco', category: 'Verduras', unit: 'un', image: 'assets/images/lechuga.png'),
  Product(name: 'Espinaca', price: 4200, provider: 'Farmáltor', category: 'Verduras', image: 'assets/images/espinaca.png'),
  Product(name: 'Acelga', price: 3800, provider: 'Campo Fresco', category: 'Verduras', image: 'assets/images/acelga.png'),
  Product(name: 'Brócoli', price: 5500, provider: 'Supermercado', category: 'Verduras', image: 'assets/images/brocoli.png'),
  Product(name: 'Coliflor', price: 5200, provider: 'Supermercado', category: 'Verduras', unit: 'un', image: 'assets/images/coliflor.png'),
  Product(name: 'Repollo', price: 3600, provider: 'Campo Fresco', category: 'Verduras', unit: 'un', image: 'assets/images/repollo.png'),
  Product(name: 'Apio', price: 3900, provider: 'Farmáltor', category: 'Verduras', image: 'assets/images/apio.png'),
  Product(name: 'Pepino', price: 3200, provider: 'Campo Fresco', category: 'Verduras', image: 'assets/images/pepino.png'),
  Product(name: 'Calabacín', price: 4600, provider: 'Supermercado', category: 'Verduras', image: 'assets/images/calabacin.png'),
  Product(name: 'Berenjena', price: 5100, provider: 'Farmáltor', category: 'Verduras', image: 'assets/images/berenjena.png'),

  // ------------------------------------------------------------ HORTALIZAS
  Product(name: 'Tomate', price: 4100, provider: 'Campo Fresco', category: 'Hortalizas', image: 'assets/images/tomate.png'),
  Product(name: 'Cebolla cabezona', price: 3800, provider: 'Farmáltor', category: 'Hortalizas', image: 'assets/images/cebolla_cabezona.png'),
  Product(name: 'Cebolla larga', price: 3200, provider: 'Campo Fresco', category: 'Hortalizas', image: 'assets/images/cebolla_larga.png'),
  Product(name: 'Zanahoria', price: 2900, provider: 'Supermercado', category: 'Hortalizas', image: 'assets/images/zanahoria.png'),
  Product(name: 'Pimentón', price: 6200, provider: 'Farmáltor', category: 'Hortalizas', image: 'assets/images/pimenton.png'),
  Product(name: 'Ajo', price: 12000, provider: 'Supermercado', category: 'Hortalizas', image: 'assets/images/ajo.png'),
  Product(name: 'Remolacha', price: 3400, provider: 'Campo Fresco', category: 'Hortalizas', image: 'assets/images/remolacha.png'),
  Product(name: 'Habichuela', price: 5600, provider: 'Farmáltor', category: 'Hortalizas', image: 'assets/images/habichuela.png'),
  Product(name: 'Arveja', price: 7800, provider: 'Campo Fresco', category: 'Hortalizas', image: 'assets/images/arveja.png'),
  Product(name: 'Mazorca', price: 2500, provider: 'Campo Fresco', category: 'Hortalizas', unit: 'un', image: 'assets/images/mazorca.png'),

  // ------------------------------------------------------------ TUBÉRCULOS
  Product(name: 'Yuca', price: 2800, provider: 'Supermercado', category: 'Tubérculos', image: 'assets/images/yuca.png'),
  Product(name: 'Arracacha', price: 4200, provider: 'Farmáltor', category: 'Tubérculos', image: 'assets/images/arracacha.png'),
  Product(name: 'Papa pastusa', price: 2600, provider: 'Campo Fresco', category: 'Tubérculos', image: 'assets/images/papa_pastusa.png'),
  Product(name: 'Papa criolla', price: 4500, provider: 'Farmáltor', category: 'Tubérculos', image: 'assets/images/papa_criolla.png'),
  Product(name: 'Papa sabanera', price: 3100, provider: 'Campo Fresco', category: 'Tubérculos', image: 'assets/images/papa_sabanera.png'),
  Product(name: 'Ñame', price: 3900, provider: 'Supermercado', category: 'Tubérculos', image: 'assets/images/name.png'),
  Product(name: 'Plátano verde', price: 3500, provider: 'Farmáltor', category: 'Tubérculos', unit: 'un', image: 'assets/images/platano_verde.png'),
  Product(name: 'Ulluco', price: 5200, provider: 'Campo Fresco', category: 'Tubérculos', image: 'assets/images/ulluco.png'),

  // --------------------------------------------------------------- HIERBAS
  Product(name: 'Cilantro', price: 1500, provider: 'Campo Fresco', category: 'Hierbas', unit: 'manojo', image: 'assets/images/cilantro.png'),
  Product(name: 'Perejil', price: 1500, provider: 'Farmáltor', category: 'Hierbas', unit: 'manojo', image: 'assets/images/perejil.png'),
  Product(name: 'Hierbabuena', price: 1800, provider: 'Campo Fresco', category: 'Hierbas', unit: 'manojo', image: 'assets/images/hierbabuena.png'),
  Product(name: 'Albahaca', price: 2200, provider: 'Farmáltor', category: 'Hierbas', unit: 'manojo', image: 'assets/images/albahaca.png'),
  Product(name: 'Laurel', price: 2000, provider: 'Supermercado', category: 'Hierbas', unit: 'manojo', image: 'assets/images/laurel.png'),
];

/// Lista de categorías para los chips/filtros, en el orden que se muestra.
const List<String> categories = [
  'Todas',
  'Frutas',
  'Verduras',
  'Hortalizas',
  'Tubérculos',
  'Hierbas',
];
