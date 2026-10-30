import 'package:flutter/material.dart';
import '../theme.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('My Tickets')),
    body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.confirmation_number_outlined, size: 70, color: Colors.grey.shade400),
      const SizedBox(height: 12),
      const Text('No tickets yet'),
      const SizedBox(height: 6),
      const Text('Book an MTC / Metro / Train ticket',
        style: TextStyle(color: Colors.grey, fontSize: 12)),
      const SizedBox(height: 20),
      FilledButton(onPressed: () {}, child: const Text('Book a Ticket')),
    ])),
  );
}
