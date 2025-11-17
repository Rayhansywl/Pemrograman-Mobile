// lib/add_activity_page.dart

import 'package:flutter/material.dart';
import 'package:student_activity_tracker/model/activity_model.dart';
import 'package:uuid/uuid.dart';

class AddActivityPage extends StatefulWidget {
  final Function(Activity) onActivityAdded;

  const AddActivityPage({super.key, required this.onActivityAdded});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _catatanController = TextEditingController();

  String _selectedKategori = 'Belajar';
  int _durasi = 1;
  bool _isSelesai = false;

  final List<String> _kategoriOptions = [
    'Belajar', 'Ibadah', 'Olahraga', 'Hiburan', 'Lainnya'
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  void _simpanAktivitas() {
    if (_formKey.currentState!.validate()) {
      var uuid = Uuid();
      final newActivity = Activity(
        id: uuid.v4(),
        nama: _namaController.text,
        kategori: _selectedKategori,
        durasi: _durasi,
        isSelesai: _isSelesai,
        catatan: _catatanController.text.isEmpty ? null : _catatanController.text,
      );

      widget.onActivityAdded(newActivity);

      // Reset form
      _formKey.currentState?.reset();
      _namaController.clear();
      _catatanController.clear();
      setState(() {
        _selectedKategori = 'Belajar';
        _durasi = 1;
        _isSelesai = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ambil warna teks/ikon utama dari tema
    final Color primaryTextColor = Theme.of(context).colorScheme.onSurface;

    // --- PERUBAHAN DI SINI ---
    // Definisikan border kustom agar bisa dipakai ulang
    // Ini adalah border saat field TIDAK FOKUS
    final OutlineInputBorder customEnabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      // Gunakan warna dinamis untuk garis border
      borderSide: BorderSide(color: primaryTextColor.withOpacity(0.5)), 
    );

    // Definisikan border saat field FOKUS
    // Kita tetap gunakan warna primer (biru/cyan) agar pengguna tahu field mana yang aktif
    final OutlineInputBorder customFocusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
    );
    // --- AKHIR PERUBAHAN ---

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Aktivitas Baru'),
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Nama Aktivitas
              TextFormField(
                controller: _namaController,
                style: TextStyle(color: primaryTextColor), // Teks input
                decoration: InputDecoration(
                  labelText: 'Nama Aktivitas',
                  labelStyle: TextStyle(color: primaryTextColor), // Teks label
                  hintText: 'Contoh: Nonton Bioskop',
                  hintStyle: TextStyle(color: primaryTextColor.withOpacity(0.7)), // Teks hint
                  prefixIcon: const Icon(Icons.description_rounded),
                  prefixIconColor: primaryTextColor, // Ikon
                  
                  // Terapkan border kustom
                  border: customEnabledBorder,
                  enabledBorder: customEnabledBorder,
                  focusedBorder: customFocusedBorder,
                  
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Aktivitas tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // 2. Kategori Aktivitas
              DropdownButtonFormField<String>(
                value: _selectedKategori,
                style: TextStyle(color: primaryTextColor), // Teks terpilih
                decoration: InputDecoration(
                  labelText: 'Kategori Aktivitas',
                  labelStyle: TextStyle(color: primaryTextColor), // Teks label
                  prefixIcon: const Icon(Icons.category_rounded),
                  prefixIconColor: primaryTextColor, // Ikon

                  // Terapkan border kustom
                  border: customEnabledBorder,
                  enabledBorder: customEnabledBorder,
                  focusedBorder: customFocusedBorder,

                  filled: true,
                ),
                // Atur warna teks di dalam dropdown list
                dropdownColor: Theme.of(context).colorScheme.surface, 
                items: _kategoriOptions.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedKategori = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // 3. Durasi (Slider) - Tidak Diubah
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Durasi (Jam): $_durasi',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Slider(
                        value: _durasi.toDouble(),
                        min: 1.0,
                        max: 8.0,
                        divisions: 7,
                        label: _durasi.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _durasi = value.round();
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('1 jam', style: Theme.of(context).textTheme.bodySmall),
                          Text('8 jam', style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 4. Status Aktivitas - Tidak Diubah
              SwitchListTile(
                title: const Text('Status Aktivitas'),
                subtitle: Text(_isSelesai ? 'Sudah Selesai' : 'Belum Selesai'),
                value: _isSelesai,
                onChanged: (bool value) {
                  setState(() {
                    _isSelesai = value;
                  });
                },
                secondary: Icon(
                  _isSelesai ? Icons.check_circle_rounded : Icons.pending_actions_rounded,
                  color: _isSelesai ? Colors.green : Colors.orange,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              ),
              const SizedBox(height: 20),

              // 5. Catatan Tambahan
              TextFormField(
                controller: _catatanController,
                maxLines: 4,
                style: TextStyle(color: primaryTextColor), // Teks input
                decoration: InputDecoration(
                  labelText: 'Catatan Tambahan',
                  labelStyle: TextStyle(color: primaryTextColor), // Teks label
                  hintText: 'Detail mengenai aktivitas...',
                  hintStyle: TextStyle(color: primaryTextColor.withOpacity(0.7)), // Teks hint
                  prefixIcon: const Icon(Icons.notes_rounded),
                  prefixIconColor: primaryTextColor, // Ikon

                  // Terapkan border kustom
                  border: customEnabledBorder,
                  enabledBorder: customEnabledBorder,
                  focusedBorder: customFocusedBorder,

                  filled: true,
                ),
              ),
              const SizedBox(height: 30),

              // 6. Tombol Simpan (Tetap Sama)
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.primary
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: _simpanAktivitas,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Simpan Aktivitas Baru',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}