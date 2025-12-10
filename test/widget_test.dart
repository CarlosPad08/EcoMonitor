import 'package:flutter_test/flutter_test.dart';
import 'package:eco_monitor/features/weather/presentation/pages/alerts_page.dart';
import 'package:eco_monitor/features/weather/presentation/pages/favorites_page.dart';
import 'package:eco_monitor/features/weather/presentation/pages/home_page.dart';
import 'package:eco_monitor/features/weather/presentation/pages/settings_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('AlertsPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AlertsPage(),
        ),
      ),
    );

    expect(find.byType(AlertsPage), findsOneWidget);
  });

  testWidgets('FavoritesPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: FavoritesPage(),
        ),
      ),
    );

    expect(find.byType(FavoritesPage), findsOneWidget);
  });

  testWidgets('HomePage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('SettingsPage renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: SettingsPage(),
        ),
      ),
    );

    expect(find.byType(SettingsPage), findsOneWidget);
  });
}
