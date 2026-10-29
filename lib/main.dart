import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/home_screen.dart';

void main() => runApp(const BusApp());

class BusApp extends StatelessWidget {
  const BusApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Chennai Bus',
    debugShowCheckedModeBanner: false,
    theme: chennaiTheme,
    home: const RootNav(),
  );
}
