import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/dosen_model.dart';
import '../widgets/dosen_card.dart';

class DosenListPage extends StatefulWidget {
  const DosenListPage({super.key});

  @override
  _DosenListPageState createState() => _DosenListPageState();
}

class _DosenListPageState extends State<DosenListPage> {
  List<Dosen> _dosenTampil = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dosenTampil = semuaDosen;
  }

  void _filterDosen(String query) {
    List<Dosen> hasilFilter = semuaDosen;
    if (query.isNotEmpty) {
      hasilFilter = semuaDosen
          .where(
            (dosen) => dosen.nama.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    setState(() {
      _dosenTampil = hasilFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.school, color: Colors.white, size: 28),
                  SizedBox(width: 8),
                  Text(
                    'APLIKASI PROFIL DOSEN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterDosen,
              decoration: InputDecoration(
                labelText: 'Cari Dosen...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
              ),
            ),
          ),

         
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemCount: _dosenTampil.length,
                itemBuilder: (context, index) {
                  final dosen = _dosenTampil[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(child: DosenCard(dosen: dosen)),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
