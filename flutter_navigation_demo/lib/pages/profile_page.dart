import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(radius: 60, backgroundImage: AssetImage('assets/profile.jpg')),
          SizedBox(height: 12),
          Text('Rayhan Syawal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Developer', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
