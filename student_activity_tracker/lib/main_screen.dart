// lib/main_screen.dart

import 'package:flutter/material.dart';
import 'package:student_activity_tracker/home_page.dart';
import 'package:student_activity_tracker/add_activity_page.dart';
import 'package:student_activity_tracker/profile_page.dart'; // File baru
import 'package:student_activity_tracker/model/activity_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Untuk jsonEncode/Decode

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Indeks tab yang aktif

  // ==========================================================
  // STATE DIANGKAT KE SINI (LIFTED STATE)
  // ==========================================================
  final List<Activity> _daftarAktivitas = [];
  late SharedPreferences _prefs; // Untuk penyimpanan lokal

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk memuat data saat aplikasi dimulai
    _loadAktivitas();
  }

  // --- Fitur Bonus: SharedPreferences ---

  Future<void> _loadAktivitas() async {
    _prefs = await SharedPreferences.getInstance();
    final String? dataString = _prefs.getString('aktivitasList');

    if (dataString != null) {
      final List<dynamic> jsonList = jsonDecode(dataString);
      setState(() {
        _daftarAktivitas.clear();
        _daftarAktivitas.addAll(
            jsonList.map((json) => Activity.fromJson(json)).toList());
      });
    }
  }

  Future<void> _saveAktivitas() async {
    // Ubah List<Activity> menjadi List<Map<String, dynamic>> lalu ke String
    final List<Map<String, dynamic>> jsonList =
        _daftarAktivitas.map((activity) => activity.toJson()).toList();
    final String dataString = jsonEncode(jsonList);
    await _prefs.setString('aktivitasList', dataString);
  }

  // --- Fungsi Callback untuk Mengubah State ---

  // Callback untuk AddActivityPage
  void _addActivity(Activity newActivity) {
    setState(() {
      _daftarAktivitas.add(newActivity);
    });
    _saveAktivitas(); // Simpan setiap kali ada data baru
    
    // Pindah ke tab Home untuk melihat hasilnya
    _onItemTapped(0); 
    
    // Tampilkan SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${newActivity.nama}" berhasil ditambahkan!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Callback untuk HomePage (dan Search)
  void _deleteActivity(String id) {
    setState(() {
      _daftarAktivitas.removeWhere((activity) => activity.id == id);
    });
    _saveAktivitas(); // Simpan setiap kali ada data dihapus
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Aktivitas berhasil dihapus!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // --- Navigasi Tab ---

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Daftar halaman/tab
    // Didefinisikan di dalam build agar HomePage selalu mendapat data terbaru
    final List<Widget> pages = <Widget>[
      // Tab 0: HomePage (sekarang menerima data)
      HomePage(
        daftarAktivitas: _daftarAktivitas,
        onDeleteActivity: _deleteActivity, // Teruskan fungsi hapus
      ),
      // Tab 1: AddActivityPage (sekarang menerima callback)
      AddActivityPage(
        onActivityAdded: _addActivity, // Teruskan callback tambah
      ),
      // Tab 2: ProfilePage
      const ProfilePage(),
    ];
    
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages, // Tampilkan halaman sesuai indeks
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_rounded),
            label: 'Tambah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}