import 'package:flutter/material.dart';
import '../models.dart';
import '../services/pass_store.dart';
import '../theme.dart';
import 'my_pass_screen.dart';

class BuyPassScreen extends StatefulWidget {
  final PassType type;
  const BuyPassScreen({super.key, required this.type});
  @override
  State<BuyPassScreen> createState() => _BuyPassScreenState();
}

class _BuyPassScreenState extends State<BuyPassScreen> {
  bool paying = false;

  Future<void> _pay() async {
    setState(() => paying = true);
    // Demo payment — replace with Razorpay/UPI later.
    await Future.delayed(const Duration(seconds: 2));
    final list = await PassStore.buy(widget.type);
    setState(() => paying = false);
    if (!mounted) return;
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (_) => MyPassScreen(pass: list.first)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Confirm Purchase')),
    body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
        CircleAvatar(radius: 30, backgroundColor: kPurple,
          child: const Icon(Icons.card_membership, color: Colors.white, size: 32)),
        const SizedBox(height: 12),
        Text(widget.type.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 4),
        Text(widget.type.subtitle, textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey)),
        const Divider(height: 32),
        _row('Validity', '${widget.type.durationDays} days'),
        const SizedBox(height: 8),
        _row('Amount', '₹${widget.type.price}'),
      ]))),
      const Spacer(),
      SizedBox(width: double.infinity, child: FilledButton(
        onPressed: paying ? null : _pay,
        child: paying
          ? const SizedBox(height: 20, width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : Text('Pay ₹${widget.type.price}')),
      ),
      const SizedBox(height: 8),
      const Text('Demo payment • replace with UPI/Razorpay for production',
        style: TextStyle(fontSize: 11, color: Colors.grey)),
    ])),
  );

  static Widget _row(String a, String b) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [Text(a), Text(b, style: const TextStyle(fontWeight: FontWeight.bold))]);
}
