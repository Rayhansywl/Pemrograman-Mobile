// lib/home_page.dart

import 'package:flutter/material.dart';
import 'package:student_activity_tracker/activity_detail_page.dart';
import 'package:student_activity_tracker/model/activity_model.dart';
import 'package:student_activity_tracker/activity_search_delegate.dart';

class HomePage extends StatelessWidget {
  final List<Activity> daftarAktivitas;
  final Function(String) onDeleteActivity;

  const HomePage({
    super.key,
    required this.daftarAktivitas,
    required this.onDeleteActivity,
  });

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Belajar': return Icons.book_rounded;
      case 'Ibadah': return Icons.self_improvement_rounded;
      case 'Olahraga': return Icons.fitness_center_rounded;
      case 'Hiburan': return Icons.movie_rounded;
      default: return Icons.widgets_rounded;
    }
  }

  void _navigasiKeDetail(BuildContext context, Activity activity) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivityDetailPage(activity: activity),
      ),
    );

    if (result == 'delete') {
      onDeleteActivity(activity.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ... (SliverAppBar tetap sama) ...
          SliverAppBar(
            expandedHeight: 180.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                child: Padding(
                  padding: const EdgeInsets.only(top: kToolbarHeight + 16, left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Student Activity Tracker',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Selamat datang, Rayhan Syawal...',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white, size: 28),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ActivitySearchDelegate(
                      searchList: daftarAktivitas,
                      onDeleteActivity: onDeleteActivity,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: daftarAktivitas.isEmpty
                ? SliverFillRemaining(
                    // ... (Tampilan 'kosong' tetap sama) ...
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_rounded, size: 80, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'Belum ada aktivitas.\nSilahkan, tambah di tab "Tambah"',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverList.builder(
                    itemCount: daftarAktivitas.length,
                    itemBuilder: (context, index) {
                      final activity = daftarAktivitas[index];
                      return Card(
                        child: InkWell(
                          onTap: () => _navigasiKeDetail(context, activity),
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                // ... (Ikon Kategori tetap sama) ...
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: activity.isSelesai
                                        ? Colors.green.shade100
                                        : Theme.of(context).colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    _getCategoryIcon(activity.kategori),
                                    color: activity.isSelesai
                                        ? Colors.green.shade700
                                        : Theme.of(context).colorScheme.onPrimaryContainer,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // ... (Nama & Detail tetap sama) ...
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activity.nama,
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${activity.durasi} jam • ${activity.kategori}',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: Colors.grey.shade600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // --- PERBAIKAN DI SINI ---
                                // Mengganti Chip dengan Icon
                                Icon(
                                  activity.isSelesai 
                                    ? Icons.check_circle_rounded 
                                    : Icons.pending_actions_rounded,
                                  color: activity.isSelesai 
                                    ? Colors.green 
                                    : Colors.orange,
                                  size: 28,
                                ),
                                // --- AKHIR PERBAIKAN ---
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}