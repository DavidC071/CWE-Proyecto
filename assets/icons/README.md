# Íconos de productos (respaldo)

Esta carpeta es **opcional**. Sirve para poner un ícono sencillo (dibujo o
emoji exportado como PNG) cuando todavía no tienes la foto real del producto.

## Orden de prioridad de la imagen en cada tarjeta

1. Foto real en `assets/images/<nombre>.png`  ← lo ideal
2. Ícono en `assets/icons/<nombre>.png`        ← este respaldo
3. Emoji automático según la categoría          ← si no hay nada de lo anterior

El `<nombre>` se calcula a partir del nombre del producto (minúsculas, sin
tildes y con `_` en vez de espacios). Ejemplos:

| Producto         | Nombre de archivo        |
|------------------|--------------------------|
| Lulo             | `lulo.png`               |
| Tomate de árbol  | `tomate_de_arbol.png`    |
| Papa criolla     | `papa_criolla.png`       |
| Limón Tahití     | `limon_tahiti.png`       |

> Consejo: puedes usar packs de íconos de frutas/verduras (p. ej. de
> flaticon.com o íconos emoji exportados) a 128×128 px en PNG transparente.
