// lib/profile_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_activity_tracker/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil & Pengaturan'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // --- PERBAIKAN DI SINI ---
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              backgroundImage: const AssetImage('assets/images/profile.png'),
              // Properti 'child' (yang berisi Icon) sudah dihapus
              // untuk mencegah tumpang tindih dengan backgroundImage.
              onBackgroundImageError: (_, __) {
                // Opsional: Beri tahu konsol jika gambar gagal dimuat
                debugPrint("Gagal memuat gambar profil: assets/images/profile.png");
              },
            ),
            // --- AKHIR PERBAIKAN ---

            const SizedBox(height: 12),
            Text(
              'Rayhan Syawal', // Ganti dengan nama Anda
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              '701230048',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
            const SizedBox(height: 30),
            
            // Toggle Dark Mode
            Card(
              child: SwitchListTile(
                title: const Text('Mode Gelap'),
                subtitle: Text(isDarkMode ? 'Aktif' : 'Nonaktif'),
                value: isDarkMode,
                onChanged: (bool value) {
                  themeProvider.toggleTheme(value);
                },
                secondary: Icon(
                  isDarkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}