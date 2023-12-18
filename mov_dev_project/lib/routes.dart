import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/dashboard_page.dart';
// ignore: library_prefixes
import 'screens/details_page.dart' as DetailsPage;
import 'screens/settings_page.dart';
import 'screens/randomizer_page.dart';
import 'screens/search_key_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case '/details':
        return MaterialPageRoute(
          builder: (_) => const DetailsPage.DetailsPage(
            slipId: 0,
            advice: "",
          ),
        );
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case '/randomizer':
        return MaterialPageRoute(builder: (_) => const RandomizerPage());
      case '/searchKey':
        return MaterialPageRoute(builder: (_) => const SearchKeyPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
    }
  }
}
