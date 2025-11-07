import 'package:flutter/material.dart';
import 'home_page.dart'; // Import file halaman utama

void main() {
  runApp(const NavigasiApp());
}

class NavigasiApp extends StatelessWidget {
  const NavigasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Profil Keren',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins', // (Opsional) Gunakan font yang menarik
      ),
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      home: const HomePage(),
    );
  }
}
