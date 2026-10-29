import 'package:flutter/material.dart';
import '../theme.dart';
import 'passes_screen.dart';
import 'tickets_screen.dart';
import 'tracking_screen.dart';
import 'profile_screen.dart';

class RootNav extends StatefulWidget {
  const RootNav({super.key});
  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  int idx = 0;
  late final pages = [
    const DashboardTab(),
    const TrackingScreen(),
    const TicketsScreen(),
    const PassesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: idx, children: pages),
    bottomNavigationBar: NavigationBar(
      selectedIndex: idx,
      onDestinationSelected: (i) => setState(() => idx = i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.location_on_outlined), label: 'Track'),
        NavigationDestination(icon: Icon(Icons.confirmation_number_outlined), label: 'Tickets'),
        NavigationDestination(icon: Icon(Icons.card_membership_outlined), label: 'Passes'),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    ),
  );
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.transparent,
    body: SafeArea(child: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(children: [
          const CircleAvatar(radius: 22, backgroundColor: kPurple,
            child: Icon(Icons.person, color: Colors.white)),
          const SizedBox(width: 12),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Hi, Commuter 👋', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('One City, One Ticket', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ])),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
        ]),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              _field(context, 'From', Icons.my_location),
              const Divider(height: 24),
              _field(context, 'To', Icons.place_outlined),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: FilledButton.icon(
                onPressed: () {}, icon: const Icon(Icons.search), label: const Text('Find Buses'))),
            ]),
          ),
        ),
        const SizedBox(height: 20),
        const Text('Quick Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4, mainAxisSpacing: 12, crossAxisSpacing: 12,
          children: const [
            _Quick(Icons.qr_code_scanner, 'Scan & Book'),
            _Quick(Icons.directions_bus, 'MTC Bus'),
            _Quick(Icons.subway, 'Metro'),
            _Quick(Icons.train, 'Train'),
          ]),
        const SizedBox(height: 20),
        const Text('Nearby Stops', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        ...[ 'Broadway Bus Terminus — 250 m', 'Egmore — 600 m', 'T Nagar — 1.2 km' ]
          .map((s) => Card(child: ListTile(
            leading: const Icon(Icons.directions_bus, color: kPurple),
            title: Text(s), trailing: const Icon(Icons.chevron_right)))),
      ],
    )),
  );

  static Widget _field(BuildContext c, String label, IconData icon) => Row(children: [
    Icon(icon, color: kPurple), const SizedBox(width: 12),
    Expanded(child: TextField(decoration: InputDecoration(
      labelText: label, border: InputBorder.none))),
  ]);
}

class _Quick extends StatelessWidget {
  final IconData icon; final String label;
  const _Quick(this.icon, this.label);
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: kPurple), const SizedBox(height: 6),
      Text(label, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
    ]));
}
