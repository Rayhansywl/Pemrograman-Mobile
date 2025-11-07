import 'package:flutter/material.dart';
import '../models/dashboard_item.dart';

class EditItemPage extends StatefulWidget {
  final DashboardItem item;
  const EditItemPage({super.key, required this.item});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.item.title);
    _descCtrl = TextEditingController(text: widget.item.description);
  }

  void _save() {
    final title = _titleCtrl.text.trim();
    final desc = _descCtrl.text.trim();
    if (title.isEmpty) return;
    Navigator.pop(
        context,
        DashboardItem(
            id: widget.item.id, title: title, description: desc));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Edit Catatan'),
          backgroundColor: const Color.fromARGB(255, 0, 89, 255),
          foregroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                  labelText: 'Judul', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(
              controller: _descCtrl,
              minLines: 3,
              maxLines: 6,
              decoration: const InputDecoration(
                  labelText: 'Deskripsi', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: const Text('Simpan'),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 89, 255), foregroundColor: Colors.white),
          )
        ]),
      ),
    );
  }
}
