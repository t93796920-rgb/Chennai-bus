import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models.dart';
import '../services/pass_store.dart';
import '../theme.dart';

class MyPassScreen extends StatefulWidget {
  final UserPass pass;
  const MyPassScreen({super.key, required this.pass});
  @override
  State<MyPassScreen> createState() => _MyPassScreenState();
}

class _MyPassScreenState extends State<MyPassScreen> {
  late UserPass pass;
  @override
  void initState() { super.initState(); pass = widget.pass; }

  Future<void> _activate() async {
    await PassStore.activate(pass.id);
    setState(() => pass.active = true);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pass activated')));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('My Pass')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [kPurple, Color(0xFF6C4CE0)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(22)),
        child: Column(children: [
          Text(pass.typeName, style: const TextStyle(color: Colors.white,
            fontWeight: FontWeight.bold, fontSize: 22)),
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: QrImageView(data: pass.qrToken, size: 220, version: QrVersions.auto)),
          const SizedBox(height: 16),
          Text(pass.qrToken, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 12),
          Chip(
            backgroundColor: pass.active ? Colors.green : Colors.orange,
            label: Text(pass.active ? 'ACTIVE' : 'NOT ACTIVATED',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
      const SizedBox(height: 20),
      _info('Pass ID', pass.id),
      _info('Valid from', pass.validFrom.toString().split('.')[0]),
      _info('Valid until', pass.validUntil.toString().split('.')[0]),
      _info('Amount paid', '₹${pass.pricePaise ~/ 100}'),
      const SizedBox(height: 20),
      if (!pass.active)
        SizedBox(width: double.infinity, child: FilledButton(
          onPressed: _activate, child: const Text('Activate on Board'))),
    ]),
  );

  static Widget _info(String a, String b) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(a, style: const TextStyle(color: Colors.grey)),
      Flexible(child: Text(b, style: const TextStyle(fontWeight: FontWeight.w600))),
    ]));
}
