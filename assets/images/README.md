# Imágenes de productos (fotos)

Coloca aquí las **fotos reales** de cada fruta/verdura. La app las busca por el
nombre exacto que aparece en `lib/data/products_data.dart` (campo `image`).

## ¿Cómo hago que salga la imagen de un producto?

1. Consigue una imagen cuadrada (recomendado **512×512 px**), preferible PNG con
   fondo transparente para que combine con el tema oscuro.
2. Guárdala en esta carpeta (`assets/images/`) con **exactamente** el nombre de la
   lista de abajo. Ejemplo: la foto del lulo debe llamarse `lulo.png`.
3. Guarda el proyecto y ejecuta de nuevo la app (`flutter run`). Si cambiaste
   `pubspec.yaml`, haz primero `flutter pub get`.

> No tienes que hacer nada en el código: si el archivo existe con el nombre
> correcto, la foto aparece sola. Si **no** existe, la tarjeta muestra el
> ícono de `assets/icons/` y, si tampoco está, un emoji según la categoría.
> Por eso la app nunca se ve rota aunque falten imágenes.

## Logo

- `logo_cwe.png` → logo de la Figura 6 del documento (se muestra en el login y
  en la cabecera de Inicio). Si no lo pones, se muestra el texto "CWE" con
  degradado neón.

## Nombres de archivo esperados (uno por producto)

Frutas:
- lulo.png
- maracuya.png
- aguacate_hass.png
- guanabana.png
- tomate_de_arbol.png
- platano.png
- mango.png
- papaya.png
- pina.png
- fresa.png
- mora.png
- banano.png
- naranja.png
- mandarina.png
- limon_tahiti.png
- uva_isabella.png
- manzana.png
- pera.png
- granadilla.png
- curuba.png
- feijoa.png
- pitahaya.png
- guayaba.png
- coco.png

Verduras:
- lechuga.png
- espinaca.png
- acelga.png
- brocoli.png
- coliflor.png
- repollo.png
- apio.png
- pepino.png
- calabacin.png
- berenjena.png

Hortalizas:
- tomate.png
- cebolla_cabezona.png
- cebolla_larga.png
- zanahoria.png
- pimenton.png
- ajo.png
- remolacha.png
- habichuela.png
- arveja.png
- mazorca.png

Tubérculos:
- yuca.png
- arracacha.png
- papa_pastusa.png
- papa_criolla.png
- papa_sabanera.png
- name.png
- platano_verde.png
- ulluco.png

Hierbas:
- cilantro.png
- perejil.png
- hierbabuena.png
- albahaca.png
- laurel.png
