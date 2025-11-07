import 'package:flutter/material.dart';
import 'package:profil_dosen_app/pages/dosen_list_page.dart';

void main() {
  runApp(const ProfilDosenApp());
}

class ProfilDosenApp extends StatelessWidget {
  const ProfilDosenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APLIKASI PROFIL DOSEN',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white, // Warna teks putih
            fontWeight: FontWeight.bold, // Huruf tebal
            fontSize: 20, // Ukuran teks
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Icon (seperti panah back) juga jadi putih
          ),
        ),
      ),
      home: const DosenListPage(),
    );
  }
}
