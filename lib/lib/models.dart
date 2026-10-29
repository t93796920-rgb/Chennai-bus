import 'dart:convert';

class PassType {
  final String id, name, subtitle;
  final int durationDays, pricePaise;
  PassType({required this.id, required this.name, required this.subtitle,
    required this.durationDays, required this.pricePaise});
  int get price => pricePaise ~/ 100;
}

class UserPass {
  final String id, typeName, qrToken;
  final int pricePaise;
  final DateTime validFrom, validUntil;
  bool active;
  UserPass({required this.id, required this.typeName, required this.qrToken,
    required this.pricePaise, required this.validFrom, required this.validUntil,
    this.active = true});

  Map<String, dynamic> toJson() => {
    'id': id, 'typeName': typeName, 'qrToken': qrToken, 'pricePaise': pricePaise,
    'validFrom': validFrom.toIso8601String(),
    'validUntil': validUntil.toIso8601String(), 'active': active};

  factory UserPass.fromJson(Map<String, dynamic> m) => UserPass(
    id: m['id'], typeName: m['typeName'], qrToken: m['qrToken'],
    pricePaise: m['pricePaise'],
    validFrom: DateTime.parse(m['validFrom']),
    validUntil: DateTime.parse(m['validUntil']),
    active: m['active'] ?? true);

  static String encodeList(List<UserPass> l) =>
      jsonEncode(l.map((e) => e.toJson()).toList());
  static List<UserPass> decodeList(String s) =>
      (jsonDecode(s) as List).map((e) => UserPass.fromJson(e)).toList();
}

const kPassTypes = <PassType>[
  PassType(id: 'gold', name: 'Gold Pass', subtitle: 'Unlimited — Ordinary, Deluxe & Express',
    durationDays: 30, pricePaise: 100000),
  PassType(id: 'diamond', name: 'Diamond Pass', subtitle: 'Unlimited — All buses incl. AC',
    durationDays: 30, pricePaise: 200000),
];
