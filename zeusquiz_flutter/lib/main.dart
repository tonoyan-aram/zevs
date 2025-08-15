import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import './theme_provider.dart';
import './screens/main_screen.dart';
import './screens/game_screen.dart';
import './screens/settings_screen.dart';
import './screens/web_view_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MainScreen(),
        ),
        GoRoute(
          path: '/game',
          builder: (context, state) => const GameScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/webview',
          builder: (context, state) => const WebViewScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Zeus Quiz',
      theme: ThemeData(
        primaryColor: themeProvider.currentTheme.primary,
        hintColor: themeProvider.currentTheme.secondary,
        scaffoldBackgroundColor: themeProvider.currentTheme.background,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: themeProvider.currentTheme.text),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: themeProvider.currentTheme.primary, // Brown - Zeus's throne
          foregroundColor: themeProvider.currentTheme.secondary, // Goldenrod - Zeus's lightning
          titleTextStyle: TextStyle(
            color: themeProvider.currentTheme.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      routerConfig: _router,
    );
  }
}
