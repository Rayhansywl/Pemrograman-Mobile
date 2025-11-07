import 'package:flutter/material.dart';
import '../models/dashboard_item.dart';
import 'edit_item_page.dart';

class DetailsPage extends StatelessWidget {
  final DashboardItem item;
  const DetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: const Color.fromARGB(255, 0, 89, 255),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(item.description),
            const SizedBox(height: 24),
            Row(children: [
              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  final edited = await Navigator.push<DashboardItem>(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EditItemPage(item: item)),
                  );
                  if (edited != null && context.mounted) {
                    Navigator.pop(
                        context, DetailsResult(delete: false, editedItem: edited));
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 89, 255),
                    foregroundColor: Colors.white),
              ),
              const Spacer(),
              IconButton(
                onPressed: () =>
                    Navigator.pop(context, DetailsResult(delete: true)),
                icon: const Icon(Icons.delete, color: Colors.red),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
