import 'package:flutter/material.dart';

const kPurple = Color(0xFF3A2E8F);
const kBg = Color(0xFFF4F3FB);

final chennaiTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: kPurple, primary: kPurple),
  scaffoldBackgroundColor: kBg,
  appBarTheme: const AppBarTheme(
    backgroundColor: kPurple, foregroundColor: Colors.white, elevation: 0),
  cardTheme: const CardThemeData(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18)))),
);
