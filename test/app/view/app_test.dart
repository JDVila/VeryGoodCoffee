import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:verygoodcoffee/core/resources/database_dao_wrapper.dart';
import 'package:verygoodcoffee/core/resources/dio_wrapper.dart';
import 'package:verygoodcoffee/features/app/app.dart';
import 'package:verygoodcoffee/features/coffee_random_viewer/data/local/app_database.dart';

void main() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final dio = Dio();
  group('App', () {
    testWidgets('renders App', (tester) async {
      await tester.pumpWidget(
        App(
          databaseDaoWrapper: DatabaseDaoTest(database),
          dioWrapper: DioTest(dio),
        ),
      );
      expect(find.byIcon(Icons.coffee), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('checks Coffee Viewer Navigation Button', (tester) async {
      await tester.pumpWidget(
        App(
          databaseDaoWrapper: DatabaseDaoReal(database),
          dioWrapper: DioTest(dio),
        ),
      );
      final randomNavButton = find.text('Random Coffee');
      await tester.tap(randomNavButton);
      await tester.pumpAndSettle();
      expect(find.text('Coffee Viewer'), findsOneWidget);
    });

    testWidgets('checks Coffee Favorites Navigation Button', (tester) async {
      await tester.pumpWidget(
        App(
          databaseDaoWrapper: DatabaseDaoTest(database),
          dioWrapper: DioTest(dio),
        ),
      );
      expect(find.text('Favorite Coffees'), findsOneWidget);
      final favoriteNavButton = find.text('Favorite Coffees');
      await tester.tap(favoriteNavButton);
      await tester.pumpAndSettle();
      expect(find.text('Coffee Favorites'), findsOneWidget);
    });

    testWidgets('checks Coffee Favorites Screen is Empty', (tester) async {
      await tester.pumpWidget(
        App(
          databaseDaoWrapper: DatabaseDaoTest(database),
          dioWrapper: DioTest(dio),
        ),
      );
      expect(find.text('Favorite Coffees'), findsOneWidget);
      final favoriteNavButton = find.text('Favorite Coffees');
      await tester.tap(favoriteNavButton);
      await tester.pumpAndSettle();
      expect(find.text('Photo Filename'), findsNothing);
    });

    testWidgets('checks Coffee Viewer Add to Favorites Button', (tester) async {
      await tester.pumpWidget(
        App(
          databaseDaoWrapper: DatabaseDaoTest(database),
          dioWrapper: DioTest(dio),
        ),
      );
      final randomNavButton = find.text('Random Coffee');
      await tester.tap(randomNavButton);
      await tester.pumpAndSettle();
      expect(find.text('Coffee Viewer'), findsOneWidget);
      final favoriteButton =
          find.widgetWithIcon(IconButton, Icons.favorite_border_outlined);
      await tester.tap(favoriteButton);
      await tester.pumpAndSettle();
      expect(find.widgetWithIcon(IconButton, Icons.favorite), findsOneWidget);
    });

    testWidgets('checks Coffee Favorites Has One Picture', (tester) async {
      await tester.pumpWidget(
        App(
          databaseDaoWrapper: DatabaseDaoTest(database),
          dioWrapper: DioTest(dio),
        ),
      );
      final randomNavButton = find.text('Random Coffee');
      await tester.tap(randomNavButton);
      await tester.pumpAndSettle();
      expect(find.text('Coffee Viewer'), findsOneWidget);
      final favoriteButton =
          find.widgetWithIcon(IconButton, Icons.favorite_border_outlined);
      await tester.tap(favoriteButton);
      await tester.pumpAndSettle();
      expect(find.widgetWithIcon(IconButton, Icons.favorite), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.text('Favorite Coffees'), findsOneWidget);
      final favoriteNavButton = find.text('Favorite Coffees');
      await tester.tap(favoriteNavButton);
      await tester.pumpAndSettle();
      expect(find.text('Photo Filename:'), findsOneWidget);
    });
  });
}
