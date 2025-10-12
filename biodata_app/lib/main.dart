import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 125, 255),
          title: const Text(
            "Aplikasi Biodata",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 214, 214, 214),
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    blurRadius: 5,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama: Rayhan Syawal",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(221, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "NIM: 701230048",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(221, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Hobi: Belajar Coding",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(221, 0, 0, 0),
                      fontWeight: FontWeight.bold,
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
}
