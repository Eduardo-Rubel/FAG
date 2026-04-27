import 'package:flutter_test/flutter_test.dart';

import 'package:aula02/main.dart';

void main() {
  testWidgets('exibe a tela de cadastro', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Cadastro de Usuario'), findsOneWidget);
    expect(find.text('Preencha os campos abaixo'), findsOneWidget);
    expect(find.text('Cadastrar'), findsOneWidget);
  });
}
