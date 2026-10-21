# Carpeta del APK (descarga desde la vitrina)

El botón **"CWE.APK"** de la página `Saber_mas.php` descarga el archivo que debe
estar aquí con este nombre exacto:

```
app-release.apk
```

## ¿Cómo genero ese APK?

Desde la raíz del proyecto (donde está `pubspec.yaml`):

```
flutter build apk --release
```

El archivo queda en:
```
build/app/outputs/flutter-apk/app-release.apk
```

Copia ese archivo a esta carpeta (`Vitrina/Apk/`) y renómbralo (si hace falta) a
`app-release.apk`. Con eso el botón de descarga de la vitrina ya funcionará.

> ⚠️ El `.apk` NO se sube a GitHub (pesa mucho y está en el .gitignore).
> Cada quien lo genera en su PC o lo comparten por otro medio (Drive, etc.).
