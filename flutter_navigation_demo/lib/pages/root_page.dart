import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dashboard_item.dart';
import 'dashboard_page.dart';
import 'add_item_page.dart';
import 'profile_page.dart';
import 'details_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  List<DashboardItem> _items = [];
  int _nextId = 0;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('items');
    if (data != null) {
      final List list = jsonDecode(data);
      setState(() {
        _items = list.map((e) => DashboardItem.fromJson(e)).toList();
        if (_items.isNotEmpty) {
          _nextId =
              _items.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;
        }
      });
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'items', jsonEncode(_items.map((e) => e.toJson()).toList()));
  }

  void _addItem(String title, String desc) {
    setState(() {
      _items.insert(
          0,
          DashboardItem(
              id: _nextId++, title: title, description: desc));
      _selectedIndex = 0;
    });
    _saveItems();
  }

  void _updateItem(DashboardItem updated) {
    setState(() {
      final index = _items.indexWhere((e) => e.id == updated.id);
      if (index != -1) _items[index] = updated;
      _selectedIndex = 0;
    });
    _saveItems();
  }

  void _removeItem(int id) {
    setState(() => _items.removeWhere((e) => e.id == id));
    _saveItems();
  }

  Future<void> _openDetails(DashboardItem item) async {
    final result = await Navigator.push<DetailsResult>(
      context,
      MaterialPageRoute(
          builder: (_) => DetailsPage(item: item)),
    );
    if (result != null) {
      if (result.delete) {
        _removeItem(item.id);
      } else if (result.editedItem != null) {
        _updateItem(result.editedItem!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 760;
    final pages = [
      DashboardPage(items: _items, onOpen: _openDetails),
      AddItemPage(onAdd: _addItem),
      const ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Notebook - ku', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 0, 89, 255),
        centerTitle: true,
      ),
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              backgroundColor: const Color.fromARGB(255, 0, 89, 255),
              indicatorColor: Colors.white24,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) =>
                  setState(() => _selectedIndex = i),
              labelType: NavigationRailLabelType.all,
              unselectedIconTheme:
                  const IconThemeData(color: Colors.white),
              selectedIconTheme:
                  const IconThemeData(color: Colors.white),
              unselectedLabelTextStyle:
                  const TextStyle(color: Colors.white),
              selectedLabelTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text('Dashboard')),
                NavigationRailDestination(
                    icon: Icon(Icons.add_box_outlined),
                    selectedIcon: Icon(Icons.add_box),
                    label: Text('Tambah')),
                NavigationRailDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Profil')),
              ],
            ),
          Expanded(child: pages[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: isWide
          ? null
          : NavigationBarTheme(
              data: NavigationBarThemeData(
                backgroundColor:
                    const Color.fromARGB(255, 0, 89, 255),
                indicatorColor: Colors.white24,
                labelTextStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.white)),
              ),
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (i) =>
                    setState(() => _selectedIndex = i),
                destinations: const [
                  NavigationDestination(
                      icon: Icon(Icons.home_outlined, color: Colors.white),
                      label: 'Dashboard'),
                  NavigationDestination(
                      icon: Icon(Icons.add_box_outlined,
                          color: Colors.white),
                      label: 'Tambah'),
                  NavigationDestination(
                      icon: Icon(Icons.person_outline, color: Colors.white),
                      label: 'Profil'),
                ],
              ),
            ),
    );
  }
}
