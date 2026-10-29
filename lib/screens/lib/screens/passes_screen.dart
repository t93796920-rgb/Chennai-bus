import 'package:flutter/material.dart';
import '../models.dart';
import '../services/pass_store.dart';
import '../theme.dart';
import 'buy_pass_screen.dart';
import 'my_pass_screen.dart';

class PassesScreen extends StatefulWidget {
  const PassesScreen({super.key});
  @override
  State<PassesScreen> createState() => _PassesScreenState();
}

class _PassesScreenState extends State<PassesScreen> {
  List<UserPass> mine = [];
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async { mine = await PassStore.load(); if (mounted) setState(() {}); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Travel Passes')),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      if (mine.isNotEmpty) ...[
        const Text('My Passes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        ...mine.map((p) => Card(child: ListTile(
          leading: const Icon(Icons.card_membership, color: kPurple),
          title: Text(p.typeName),
          subtitle: Text('Valid till ${p.validUntil.toString().split(" ")[0]}'),
          trailing: const Icon(Icons.qr_code),
          onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => MyPassScreen(pass: p)));
            _load();
          }))),
        const SizedBox(height: 20),
      ],
      const Text('Buy a Pass', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      ...kPassTypes.map((t) => Card(child: ListTile(
        leading: CircleAvatar(backgroundColor: kPurple,
          child: Text('₹', style: const TextStyle(color: Colors.white))),
        title: Text(t.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(t.subtitle),
        trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('₹${t.price}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('30 days', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ]),
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => BuyPassScreen(type: t)));
          _load();
        }))),
    ]),
  );
}
