import 'package:crud_app/core/environments/environments.dart';
import 'package:crud_app/features/create_account/view/create_account.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //setting up
  setUp(() async {
    await dotenv.load(fileName: Environments.fileName);
  });

  //testing
  testWidgets('render create or update account page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CreateAccountPage()));

    // expectations
    expect(find.byType(TextFormField), findsNWidgets(5));
    expect(find.byType(DateTimeField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
