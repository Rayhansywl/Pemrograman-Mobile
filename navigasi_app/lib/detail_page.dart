import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  // Widget bantuan untuk membuat baris detail yang bisa digunakan ulang
  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo, size: 30),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DETAIL INFORMASI',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const SizedBox(height: 10),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tentang saya',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Saya adalah mahasiswa Program Studi Sistem Informasi di UIN Sulthan Thaha Saifuddin Jambi. Saya memiliki minat yang mendalam di bidang teknologi, khususnya pemrograman. Bagi saya, pemrograman bukan sekadar menulis kode, melainkan sebuah sarana untuk mengasah kemampuan berpikir logis, memecahkan masalah secara sistematis, dan menciptakan inovasi yang bermanfaat.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailRow(
            context,
            icon: Icons.email_rounded,
            title: 'Email',
            subtitle: 'rayhan.syawal17@gmail.com',
          ),
          const Divider(),
          _buildDetailRow(
            context,
            icon: Icons.phone_rounded,
            title: 'Nomor Telepon',
            subtitle: '+62 831-7226-2686',
          ),
          const Divider(),
          _buildDetailRow(
            context,
            icon: Icons.location_on_rounded,
            title: 'Alamat',
            subtitle:
                'Jl. Sentot Ali Basa RT. 18, Kel. Payo Selincah Kec. Paal Merah Kota Jambi',
          ),
          const Divider(),
          _buildDetailRow(
            context,
            icon: Icons.code_rounded,
            title: 'Kemampuan',
            subtitle: 'Programming, Photography, Editing, Design graphic',
          ),
          const Divider(),
          _buildDetailRow(
            context,
            icon: Icons.link_rounded,
            title: 'GitHub',
            subtitle: 'github.com/rayhansywl',
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Kembali',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
