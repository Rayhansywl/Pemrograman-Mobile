import 'package:flutter/material.dart';
import 'feedback_result_page.dart';

class FeedbackData {
  final String nama;
  final String komentar;
  final int rating;

  FeedbackData({
    required this.nama,
    required this.komentar,
    required this.rating,
  });
}

class FeedbackFormPage extends StatefulWidget {
  @override
  _FeedbackFormPageState createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _nama = '';
  String _komentar = '';
  int _rating = 5;

  List<FeedbackData> _feedbackList = [];

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _feedbackList.add(
          FeedbackData(nama: _nama, komentar: _komentar, rating: _rating),
        );
      });

      _formKey.currentState!.reset();
      setState(() => _rating = 5);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackResultPage(
            feedbackList: _feedbackList,
            onClear: _clearAllFeedback,
          ),
        ),
      );
    }
  }

  void _clearAllFeedback() {
    setState(() {
      _feedbackList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 12, 92, 213),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
              Color(0xFF90CAF9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Formulir Feedback",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildInput(
                                label: "Nama",
                                icon: Icons.person_outline,
                                onSaved: (v) => _nama = v ?? '',
                                validator: (v) =>
                                    v!.isEmpty ? "Nama harus diisi" : null,
                              ),
                              const SizedBox(height: 16),
                              _buildInput(
                                label: "Komentar",
                                icon: Icons.chat_bubble_outline,
                                maxLines: 3,
                                onSaved: (v) => _komentar = v ?? '',
                                validator: (v) =>
                                    v!.isEmpty ? "Komentar harus diisi" : null,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Rating:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  DropdownButton<int>(
                                    value: _rating,
                                    dropdownColor: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    items: List.generate(
                                      5,
                                      (i) => DropdownMenuItem(
                                        value: i + 1,
                                        child: Text("${i + 1} ⭐"),
                                      ),
                                    ),
                                    onChanged: (val) => setState(() {
                                      _rating = val!;
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildGradientButton(
                                text: "Kirim Feedback",
                                icon: Icons.send_rounded,
                                onPressed: _submitFeedback,
                              ),
                              const SizedBox(height: 12),
                              _buildGradientButton(
                                text: "Lihat Semua Feedback",
                                icon: Icons.list_alt,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FeedbackResultPage(
                                        feedbackList: _feedbackList,
                                        onClear: _clearAllFeedback,
                                      ),
                                    ),
                                  );
                                },
                                colors: const [Colors.white, Colors.white],
                                textColor: Colors.black87,
                              ),
                            ],
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
    );
  }

  Widget _buildInput({
    required String label,
    required IconData icon,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
      style: const TextStyle(color: Colors.black87),
      onSaved: onSaved,
      validator: validator,
      maxLines: maxLines,
    );
  }

  Widget _buildGradientButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    List<Color>? colors,
    Color? textColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? [const Color(0xFF1565C0), const Color(0xFF0D47A1)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: textColor ?? Colors.white),
        label: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
