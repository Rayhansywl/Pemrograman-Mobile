import 'package:flutter/material.dart';

void main() {
  runApp(const InteraksiUserApp());
}

class InteraksiUserApp extends StatelessWidget {
  const InteraksiUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interaksi User App',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const BiodataPage(),
    );
  }
}

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();

  String? _jenisKelamin;
  List<String> _hobi = [];
  String? _hasil;

  void _ubahHobi(String value, bool isChecked) {
    setState(() {
      if (isChecked) {
        _hobi.add(value);
      } else {
        _hobi.remove(value);
      }
    });
  }

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _hasil =
            '''
Nama: ${_namaController.text}
Umur: ${_umurController.text} tahun
Jenis Kelamin: ${_jenisKelamin ?? '-'}
Hobi: ${_hobi.isNotEmpty ? _hobi.join(', ') : '-'}
''';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Data berhasil disimpan!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradasi Latar Belakang
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50C9C3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: const [
                            Icon(
                              Icons.person_pin,
                              size: 90,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Form Biodata Diri',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Nama
                      TextFormField(
                        controller: _namaController,
                        decoration: InputDecoration(
                          labelText: 'Nama Lengkap',

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Nama wajib diisi'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Umur
                      TextFormField(
                        controller: _umurController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Umur',

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Umur wajib diisi';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Masukkan angka yang valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Jenis Kelamin
                      const Text(
                        'Jenis Kelamin',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RadioListTile<String>(
                        title: const Text('Laki-laki'),
                        value: 'Laki-laki',
                        groupValue: _jenisKelamin,
                        onChanged: (value) =>
                            setState(() => _jenisKelamin = value),
                      ),
                      RadioListTile<String>(
                        title: const Text('Perempuan'),
                        value: 'Perempuan',
                        groupValue: _jenisKelamin,
                        onChanged: (value) =>
                            setState(() => _jenisKelamin = value),
                      ),
                      const SizedBox(height: 20),

                      // Hobi
                      const Text(
                        'Hobi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CheckboxListTile(
                        title: const Text('Membaca'),
                        value: _hobi.contains('Membaca'),
                        onChanged: (val) => _ubahHobi('Membaca', val!),
                      ),
                      CheckboxListTile(
                        title: const Text('Coding'),
                        value: _hobi.contains('Coding'),
                        onChanged: (val) => _ubahHobi('Coding', val!),
                      ),
                      CheckboxListTile(
                        title: const Text('Musik'),
                        value: _hobi.contains('Musik'),
                        onChanged: (val) => _ubahHobi('Musik', val!),
                      ),
                      CheckboxListTile(
                        title: const Text('Olahhraga'),
                        value: _hobi.contains('Olahraga'),
                        onChanged: (val) => _ubahHobi('Olahraga', val!),
                      ),
                      const SizedBox(height: 24),

                      // Tombol Simpan dengan Gradasi
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0072FF), Color(0xFF00C6FF)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: _simpanData,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Simpan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Hasil Input
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: _hasil == null
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(thickness: 1.2),
                                  const Text(
                                    '📋 Hasil Input:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFE0F7FA),
                                          Color(0xFFB2EBF2),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    child: Text(
                                      _hasil!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
