// lib/model/activity_model.dart

class Activity {
  final String id;
  final String nama;
  final String kategori;
  final int durasi; // <-- DIUBAH DARI DOUBLE
  final bool isSelesai;
  final String? catatan;

  Activity({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.durasi, // <-- Tipe data int
    required this.isSelesai,
    this.catatan,
  });

  // --- Ubahan untuk SharedPreferences ---

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kategori': kategori,
      'durasi': durasi, // <-- Tetap aman (JSON number)
      'isSelesai': isSelesai,
      'catatan': catatan,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      nama: json['nama'],
      kategori: json['kategori'],
      // Ubah num (bisa int/double) dari JSON menjadi int
      durasi: (json['durasi'] as num).toInt(), // <-- DIUBAH
      isSelesai: json['isSelesai'],
      catatan: json['catatan'],
    );
  }
}