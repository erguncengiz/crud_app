import 'package:crud_app/constants.dart';
import 'package:crud_app/core/environments/environments.dart';
import 'package:crud_app/features/home/cubit/home_cubit.dart';
import 'package:crud_app/features/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  HomeState? homeState;
  //setting up
  setUp(() async {
    await dotenv.load(fileName: Environments.fileName);
    homeState = HomeState();
  });

  //testing
  testWidgets('renders bottom navigator row', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));
    expect(find.byKey(const ValueKey("navigator")), findsOneWidget);
  });

  testWidgets('renders body', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    switch (homeState?.pageState) {
      case PageState.error:
        expect(find.byKey(const ValueKey("errorBody")), findsOneWidget);
        break;
      case PageState.loading:
        expect(find.byKey(const ValueKey("loadingBody")), findsOneWidget);
        break;
      case PageState.done:
        expect(find.byKey(const ValueKey("successBody")), findsOneWidget);
        expect(find.byType(ListTile), findsWidgets);
        break;
      default:
        expect(find.byKey(const ValueKey("defaultBody")), findsOneWidget);
    }
  });
}
