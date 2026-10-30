import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Profile')),
    body: ListView(children: [
      const SizedBox(height: 16),
      const Center(child: CircleAvatar(radius: 40, backgroundColor: kPurple,
        child: Icon(Icons.person, color: Colors.white, size: 40))),
      const SizedBox(height: 12),
      const Center(child: Text('Commuter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
      const Center(child: Text('+91 98xxx xxxxx', style: TextStyle(color: Colors.grey))),
      const SizedBox(height: 16),
      for (final t in ['My Bookings', 'Saved Routes', 'Payment Methods',
        'Language (English / தமிழ்)', 'Help & Support', 'About'])
        ListTile(leading: const Icon(Icons.chevron_right), title: Text(t)),
    ]),
  );
}
