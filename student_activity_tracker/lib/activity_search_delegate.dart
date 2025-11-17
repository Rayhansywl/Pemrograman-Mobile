// lib/activity_search_delegate.dart

import 'package:flutter/material.dart';
import 'package:student_activity_tracker/model/activity_model.dart';
import 'package:student_activity_tracker/activity_detail_page.dart';

class ActivitySearchDelegate extends SearchDelegate<Activity?> {
  final List<Activity> searchList;
  final Function(String) onDeleteActivity;

  ActivitySearchDelegate({
    required this.searchList,
    required this.onDeleteActivity,
  });

  // ... (Helper _getCategoryIcon, buildActions, buildLeading tetap sama) ...
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Belajar': return Icons.book_rounded;
      case 'Ibadah': return Icons.self_improvement_rounded;
      case 'Olahraga': return Icons.fitness_center_rounded;
      case 'Hiburan': return Icons.movie_rounded;
      default: return Icons.widgets_rounded;
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear_rounded),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        close(context, null);
      },
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    return _buildFilteredList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildFilteredList(context);
  }

  // Widget helper untuk membangun daftar hasil
  Widget _buildFilteredList(BuildContext context) {
    final List<Activity> results = searchList
        .where((activity) =>
            activity.nama.toLowerCase().contains(query.toLowerCase()) ||
            activity.kategori.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Text('Tidak ada aktivitas ditemukan untuk "$query"'),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final activity = results[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(
              _getCategoryIcon(activity.kategori),
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(activity.nama),
            subtitle: Text(activity.kategori),

            // --- PERBAIKAN DI SINI ---
            // Mengganti Chip dengan Icon
            trailing: Icon(
              activity.isSelesai 
                ? Icons.check_circle_rounded 
                : Icons.pending_actions_rounded,
              color: activity.isSelesai 
                ? Colors.green 
                : Colors.orange,
            ),
            // --- AKHIR PERBAIKAN ---

            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityDetailPage(activity: activity),
                ),
              );
              if (result == 'delete') {
                onDeleteActivity(activity.id);
                close(context, null);
              }
            },
          ),
        );
      },
    );
  }
}