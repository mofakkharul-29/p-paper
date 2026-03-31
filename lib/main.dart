import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/core/constant/theme.dart';
import 'package:p_papper/core/routing/router_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(
      RouterConfiguration.routerProvider,
    );
    final themeMode = ref.watch(themeNotifierProvider);

    final lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFB6B4B4),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
      cardColor: Colors.white,
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(
            selectedItemColor: Colors.black87,
            unselectedItemColor: Colors.black54,
            elevation: 8,
          ),
    );

    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF1E1E1E),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white60,
            elevation: 0,
          ),
    );

    return AnimatedTheme(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      data: themeMode == ThemeMode.dark
          ? darkTheme
          : lightTheme,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerConfig: router,
      ),
    );
  }
}
