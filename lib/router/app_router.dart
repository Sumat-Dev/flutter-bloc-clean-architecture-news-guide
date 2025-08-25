import 'package:flutter/material.dart';
import '../features/articles/presentation/pages/articles_page.dart';
import '../core/common/views/page_under_construction.dart';

class AppRouter {
  static const String home = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _pageBuilder((_) => const ArticlesPage(), settings: settings);
      default:
        return _pageBuilder(
          (_) => const PageUnderConstruction(),
          settings: settings,
        );
    }
  }

  static PageRouteBuilder<dynamic> _pageBuilder(
    Widget Function(BuildContext) page, {
    required RouteSettings settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (context, _, __) => page(context),
    );
  }
}
