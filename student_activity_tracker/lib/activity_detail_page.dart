// lib/activity_detail_page.dart

import 'package:flutter/material.dart';
import 'package:student_activity_tracker/model/activity_model.dart';

class ActivityDetailPage extends StatelessWidget {
  final Activity activity;

  const ActivityDetailPage({super.key, required this.activity});

  // ... (Helper _getCategoryIcon tetap sama) ...
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Belajar': return Icons.book_rounded;
      case 'Ibadah': return Icons.self_improvement_rounded;
      case 'Olahraga': return Icons.fitness_center_rounded;
      case 'Hiburan': return Icons.movie_rounded;
      default: return Icons.widgets_rounded;
    }
  }

  // ... (Helper _buildDetailRow tetap sama) ...
  Widget _buildDetailRow(
      BuildContext context, IconData icon, String label, String value,
      {Color valueColor = Colors.black87}) {
    
    final defaultColor = Theme.of(context).textTheme.titleMedium?.color ?? Colors.black87;

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.secondary, size: 28),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: (valueColor == Colors.black87) ? defaultColor : valueColor,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  // ... (Helper _konfirmasiHapus tetap sama) ...
  void _konfirmasiHapus(BuildContext context) async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Aktivitas?'),
        content: Text('Apakah Anda yakin ingin menghapus "${activity.nama}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmDelete == true) {
      Navigator.pop(context, 'delete');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ... (AppBar tetap sama) ...
        title: const Text('Detail Aktivitas'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (Header Card tetap sama) ...
            Card(
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          _getCategoryIcon(activity.kategori),
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          size: 50,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        activity.nama,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            _buildDetailRow(
              context,
              Icons.category_rounded,
              'Kategori',
              activity.kategori,
            ),
            
            // --- MODIFIKASI TAMPILAN DURASI ---
            _buildDetailRow(
              context,
              Icons.timer_rounded,
              'Durasi',
              '${activity.durasi} jam', // <-- DIUBAH
            ),
            // --- AKHIR MODIFIKASI ---
            
            _buildDetailRow(
              context,
              activity.isSelesai ? Icons.check_circle_rounded : Icons.pending_actions_rounded,
              'Status',
              activity.isSelesai ? 'Sudah Selesai' : 'Belum Selesai',
              valueColor: activity.isSelesai ? Colors.green : Colors.orange,
            ),
            
            // ... (Catatan & Tombol-tombol tetap sama) ...
            if (activity.catatan != null && activity.catatan!.isNotEmpty)
              Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.notes_rounded, color: Theme.of(context).colorScheme.secondary),
                          const SizedBox(width: 10),
                          Text('Catatan Tambahan', style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        activity.catatan!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.arrow_back_rounded),
                label: Text(
                  'Kembali',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _konfirmasiHapus(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.delete_forever_rounded, color: Colors.white),
                label: Text(
                  'Hapus Aktivitas',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}