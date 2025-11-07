// lib/models/dosen_model.dart

class Dosen {
  final String nama;
  final String nip;
  final String email;
  final String fotoUrl;
  final String mata_kuliah;
  final String jabatan;

  Dosen({
    required this.nama,
    required this.nip,
    required this.email,
    required this.fotoUrl,
    required this.mata_kuliah,
    required this.jabatan,
  });
}

// Data Dummy
final List<Dosen> semuaDosen = [
  Dosen(
    nama: 'Wahyu Anggoro, M.Kom',
    nip: '-',
    email: '@email.ac.id',
    fotoUrl: 'assets/images/profile.png',
    mata_kuliah: 'Manajemen Risiko',
    jabatan: 'Dosen',
  ),
  Dosen(
    nama: 'POL METRA, M.Kom',
    nip: '-',
    email: '@email.ac.id',
    fotoUrl: 'assets/images/profile.png',
    mata_kuliah: 'Multimedia',
    jabatan: 'Waka Prodi Sistem Informasi',
  ),
  Dosen(
    nama: 'AHMAD NASUKHA, S.Hum., M.S.I',
    nip: '-',
    email: '@email.ac.id',
    fotoUrl: 'assets/images/profile.png',
    mata_kuliah: 'Pemrograman Mobile',
    jabatan: 'Dosen',
  ),
  Dosen(
    nama: 'DILA NURLAILA, M.Kom',
    nip: '-',
    email: '@email.ac.id',
    fotoUrl: 'assets/images/profile.png',
    mata_kuliah: 'Rekayasa Perangkat Lunak',
    jabatan: 'Dosen',
  ),
  Dosen(
    nama: 'M. YUSUF, S.Kom., M.S.I',
    nip: '-',
    email: '@email.ac.id',
    fotoUrl: 'assets/images/profile.png',
    mata_kuliah: 'Tecnopreneurship',
    jabatan: 'Dosen',
  ),
  Dosen(
    nama: 'Fatima Felawati, S.Kom.,M.Kom',
    nip: '-',
    email: '@email.ac.id',
    fotoUrl: 'assets/images/profile.png',
    mata_kuliah: 'Testing Dan Implementasi',
    jabatan: 'Dosen',
  ),
];
