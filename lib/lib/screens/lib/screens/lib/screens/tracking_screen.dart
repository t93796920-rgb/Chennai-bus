import 'package:flutter/material.dart';
import '../theme.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Live Bus Tracking')),
    body: Column(children: [
      Container(height: 280, color: Colors.blueGrey.shade100,
        child: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.map, size: 60, color: kPurple),
          Text('Live map — coming soon'),
        ]))),
      Expanded(child: ListView(children: [
        for (final b in ['18A · Broadway → Adyar · 3 min', '5B · T Nagar → Egmore · 7 min',
          '21G · Tambaram → Central · 12 min'])
          Card(child: ListTile(leading: const Icon(Icons.directions_bus, color: kPurple),
            title: Text(b))),
      ])),
    ]),
  );
}
