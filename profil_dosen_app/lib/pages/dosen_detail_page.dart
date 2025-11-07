import 'package:flutter/material.dart';
import '../models/dosen_model.dart';
import '../widgets/info_detail_card.dart';

class DosenDetailPage extends StatelessWidget {
  final Dosen dosen;
  const DosenDetailPage({super.key, required this.dosen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            // 🔹 Panah kembali hitam
            iconTheme: const IconThemeData(color: Colors.black),
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  centerTitle: false, // 🔹 Teks di kiri
                  titlePadding: const EdgeInsetsDirectional.only(
                    start: 16,
                    bottom: 16,
                    end: 16,
                  ),
                  title: Text(
                    dosen.nama,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white, // 🔹 Teks putih
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 6.0,
                          color: Colors.black54,
                          offset: Offset(1.5, 1.5),
                        ),
                      ],
                    ),
                  ),
                  background: Hero(
                    tag: dosen.nip,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // 🔹 Gambar bisa dari URL atau dari assets
                        dosen.fotoUrl.startsWith('http')
                            ? Image.network(dosen.fotoUrl, fit: BoxFit.cover)
                            : Image.asset(dosen.fotoUrl, fit: BoxFit.cover),
                        // 🔹 Tambahkan overlay transparan ringan agar gambar tetap terang
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.2),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoDetailCard(
                    title: 'Jabatan',
                    content: dosen.jabatan,
                    icon: Icons.work,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  InfoDetailCard(
                    title: 'NIP',
                    content: dosen.nip,
                    icon: Icons.badge,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 10),
                  InfoDetailCard(
                    title: 'Email',
                    content: dosen.email,
                    icon: Icons.email,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 10),
                  InfoDetailCard(
                    title: 'Mata Kuliah',
                    content: dosen.mata_kuliah,
                    icon: Icons.book,
                    color: Colors.purple,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
