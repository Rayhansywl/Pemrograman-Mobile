// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_activity_tracker/main_screen.dart'; // UBAH ke MainScreen
import 'package:student_activity_tracker/theme_provider.dart';

void main() {
  runApp(
    // 1. Bungkus seluruh aplikasi dengan Provider
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
    // 2. Gunakan Consumer untuk mendengarkan perubahan tema
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Student Activity Tracker',
          debugShowCheckedModeBanner: false,
          
          // 3. Terapkan themeMode dari provider
          themeMode: themeProvider.themeMode,

          // 4. TEMA TERANG (LIGHT MODE)
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF00ACC1),
              brightness: Brightness.light,
              primary: const Color(0xFF00ACC1),
              secondary: const Color(0xFF64B5F6),
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(bottom: 12),
            ),
          ),

          // 5. TEMA GELAP (DARK MODE)
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF00ACC1),
              brightness: Brightness.dark, // Ini kuncinya
              primary: const Color(0xFF00ACC1),
              secondary: const Color(0xFF64B5F6),
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.only(bottom: 12),
            ),
          ),
          
          // 6. Halaman utama sekarang adalah MainScreen
          home: const MainScreen(),
        );
      },
    );
  }
}