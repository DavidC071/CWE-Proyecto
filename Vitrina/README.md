# 🌐 Vitrina CWE (página web)

Página web informativa del proyecto CWE (una "vitrina"). Está hecha en **PHP**,
HTML y CSS. Tiene 3 páginas: Inicio, Quiénes somos y Saber más (con el botón
para descargar el APK).

> Es un proyecto **aparte** de la app Flutter y del backend. Vive en el mismo
> repositorio solo para que todo el equipo la tenga, pero se ejecuta por su
> cuenta con un servidor PHP.

## 📂 Estructura

```
Vitrina/
├── Src/           ← las páginas (.php)
│   ├── Inicio.php
│   ├── Quienes_somos.php
│   └── Saber_mas.php
├── Styles/        ← los estilos (.css)
├── Imagenes/      ← logo, fotos del equipo e íconos
└── Apk/           ← aquí va el app-release.apk para el botón de descarga
```

## ▶️ Cómo verla en tu PC con XAMPP (paso a paso)

Como es PHP, necesita un servidor. Usamos **XAMPP** (el que vimos en clase).

1. **Abre XAMPP** y en el panel de control pulsa **Start** en **Apache**.
   (No hace falta MySQL para esta página.)

2. **Copia la carpeta `Vitrina`** dentro de la carpeta `htdocs` de XAMPP.
   La ruta típica en Windows es:
   ```
   C:\xampp\htdocs\
   ```
   Debe quedar así: `C:\xampp\htdocs\Vitrina\...`

3. **Abre el navegador** y entra a:
   ```
   http://localhost/Vitrina/Src/Inicio.php
   ```
   ¡Listo! Ya verás la página de inicio. 🎉

   Desde ahí puedes navegar a "Quiénes somos" y "Saber más" con el menú de
   arriba.

## 📥 El botón de descarga del APK

En la página **Saber más** hay un botón **"CWE.APK"**. Para que funcione, debe
existir el archivo:
```
Vitrina/Apk/app-release.apk
```
Si aún no está, sigue las instrucciones de `Vitrina/Apk/README.md` para
generarlo con `flutter build apk --release` y copiarlo ahí.

## ❓ Problemas comunes

| Problema | Solución |
|---|---|
| La página se descarga en vez de abrirse | No estás usando XAMPP. Debes abrirla por `http://localhost/...`, no con doble clic. |
| No cargan imágenes o estilos | Verifica que copiaste la carpeta `Vitrina` COMPLETA (con Src, Styles, Imagenes). |
| El botón del APK da error 404 | Falta el archivo `Vitrina/Apk/app-release.apk` (ver arriba). |
| "Apache no inicia" en XAMPP | Otro programa usa el puerto 80 (ej. Skype). Ciérralo o cambia el puerto en XAMPP. |
