import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biodata Diri',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const BiodataScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BiodataScreen extends StatelessWidget {
  const BiodataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Memberikan warna latar belakang ke seluruh halaman
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Aplikasi Widget Dasar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // Mengatur agar Column berada di tengah secara vertikal
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // WIDGET IMAGE: Menggunakan CircleAvatar untuk tampilan bulat
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              const SizedBox(height: 24),

              // WIDGET TEXT: Untuk menampilkan nama
              const Text(
                'Rayhan Syawal',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Developer',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.indigo[400],
                  letterSpacing: 1.5,
                ),
              ),

              // Garis pemisah untuk merapikan layout
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(color: Colors.indigo[100]),
              ),

              // WIDGET ROW & COLUMN: Menggabungkan ikon dan teks
              const InfoCard(
                icon: Icons.email,
                text: 'rayhansyawal17@gmail.com',
              ),
              const SizedBox(height: 10),
              const InfoCard(icon: Icons.phone, text: '+62 83172262686'),
              const SizedBox(height: 10),
              const InfoCard(icon: Icons.location_on, text: 'Jambi, Indonesia'),
              const SizedBox(height: 30),

              // WIDGET BUTTON
              ElevatedButton(
                onPressed: () {
                  // Menampilkan SnackBar sebagai umpan balik ke pengguna
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Terima kasih telah menekan tombol'),
                      duration: Duration(seconds: 10),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo, // Warna tombol
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Tekan Tombol',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget kustom untuk menampilkan kartu info (Row) agar lebih rapi
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Icon(icon, color: Colors.indigo),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(
                color: Color.fromARGB(221, 0, 0, 0),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
