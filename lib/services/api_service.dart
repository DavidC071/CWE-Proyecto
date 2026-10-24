import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

/// Servicio que centraliza la comunicación con el backend CWE (FastAPI).

/// IMPORTANTE — la dirección del backend cambia según dónde se corras la app:
///   • Chrome / Windows / escritorio → http://127.0.0.1:8000
///   • Emulador de Android           → http://10.0.2.2:8000
///   • Celular físico (por USB/WiFi) → http://<IP-DE-TU-PC>:8000
///
/// Si corres en un celular físico, reemplaza _ipDeTuPC por la IP de tu
/// computador en la red 
class ApiService {

  // CONFIGURACIÓN (lo único que se necesita tocar para probar en el celular)

  /// ¿Vas a probar en un CELULAR FÍSICO conectado por USB/WiFi?
  ///   • false → Chrome, Windows o emulador de Android (no toques nada más)
  ///   • true  → celular físico: además escribe tu IP abajo en [_ipDeTuPC]
  static const bool _celularFisico = true;

  /// La IP de tu computador en la red WiFi (solo importa si _celularFisico=true).
  /// El PC y el celular deben estar en la MISMA red WiFi.
  static const String _ipDeTuPC = '10.127.187.153';

  /// Puerto donde corre el backend (uvicorn usa 8000 por defecto).
  static const int _puerto = 8000;

 

  /// Devuelve la URL base correcta según la plataforma.
  static String get baseUrl {
    if (kIsWeb) {
      // Web (Chrome): el navegador corre en la misma máquina que el backend.
      return 'http://127.0.0.1:$_puerto';
    }
    if (!kIsWeb && Platform.isAndroid) {
      if (_celularFisico) {
        // Celular físico: usa la IP del PC en la red WiFi.
        return 'http://$_ipDeTuPC:$_puerto';
      }
      // Emulador de Android: 10.0.2.2 apunta al "localhost" del PC.
      return 'http://10.0.2.2:$_puerto';
    }
    // Windows, macOS, Linux de escritorio.
    return 'http://127.0.0.1:$_puerto';
  }

  /// Registra un usuario nuevo en la base de datos.
  /// Devuelve el usuario creado si todo sale bien.
  /// Lanza [ApiException] con un mensaje claro si algo falla.
  static Future<Map<String, dynamic>> registrar({
    required String nombre,
    required String email,
    required String password,
    required String tipoUsuario,
  }) async {
    final url = Uri.parse('$baseUrl/usuarios/');
    try {
      final respuesta = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'nombre': nombre,
              'email': email,
              'password': password,
              'tipo_usuario': tipoUsuario,
            }),
          )
          .timeout(const Duration(seconds: 10));

      final datos = jsonDecode(utf8.decode(respuesta.bodyBytes));
      if (respuesta.statusCode == 201) {
        return datos as Map<String, dynamic>;
      }
      throw ApiException(datos['detail']?.toString() ?? 'No se pudo registrar.');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(_mensajeConexion(e));
    }
  }

  /// Inicia sesión validando el correo y la contraseña contra la base de datos.
  /// Devuelve los datos del usuario si las credenciales son correctas.
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      final respuesta = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));

      final datos = jsonDecode(utf8.decode(respuesta.bodyBytes));
      if (respuesta.statusCode == 200) {
        return datos['usuario'] as Map<String, dynamic>;
      }
      throw ApiException(
          datos['detail']?.toString() ?? 'Correo o contraseña incorrectos.');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(_mensajeConexion(e));
    }
  }

  static String _mensajeConexion(Object e) {
    return 'No se pudo conectar con el servidor.\n'
        'Verifica que el backend esté corriendo (uvicorn) y que la '
        'dirección sea la correcta.';
  }
}

/// Error con un mensaje legible para mostrar al usuario.
class ApiException implements Exception {
  final String mensaje;
  ApiException(this.mensaje);

  @override
  String toString() => mensaje;
}
