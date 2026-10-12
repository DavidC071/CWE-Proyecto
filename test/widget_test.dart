// Pruebas de la app CWE (corrección del error E-02: reemplaza el test
// de plantilla del contador, que no aplica a esta aplicación).

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cwe/main.dart';

// Simula una pantalla de celular para que todo el contenido quepa.
void _phoneSize(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

Future<void> _login(WidgetTester tester) async {
  await tester.enterText(find.byType(TextField).at(0), 'david');
  await tester.enterText(find.byType(TextField).at(1), '1234');
  await tester.tap(find.text('Iniciar Sesión'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('El login no permite entrar con campos vacíos', (tester) async {
    _phoneSize(tester);
    await tester.pumpWidget(const MyApp());

    expect(find.text('CWE'), findsOneWidget);

    await tester.tap(find.text('Iniciar Sesión'));
    await tester.pump();

    expect(find.text('Ingresa tu usuario o correo'), findsOneWidget);
    expect(find.text('Ingresa tu contraseña'), findsOneWidget);
    expect(find.text('Destacados'), findsNothing);
  });

  testWidgets('Con usuario y contraseña abre el catálogo', (tester) async {
    _phoneSize(tester);
    await tester.pumpWidget(const MyApp());
    await _login(tester);

    expect(find.text('Destacados'), findsOneWidget);
    expect(find.text('Lulo'), findsOneWidget);
  });

  testWidgets('El buscador filtra los productos', (tester) async {
    _phoneSize(tester);
    await tester.pumpWidget(const MyApp());
    await _login(tester);

    await tester.enterText(find.byType(TextField).first, 'maracuya');
    await tester.pump();

    expect(find.text('Maracuyá'), findsOneWidget);
    expect(find.text('Yuca'), findsNothing);
  });

  testWidgets('La barra inferior cambia de pestaña', (tester) async {
    _phoneSize(tester);
    await tester.pumpWidget(const MyApp());
    await _login(tester);

    await tester.tap(find.text('Mis Pedidos'));
    await tester.pump();
    expect(find.text('Aún no tienes pedidos'), findsOneWidget);
  });
}
