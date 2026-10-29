import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models.dart';

class PassStore {
  static const _key = 'my_passes';

  static Future<List<UserPass>> load() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getString(_key);
    return raw == null ? [] : UserPass.decodeList(raw);
  }

  static Future<List<UserPass>> buy(PassType t) async {
    final list = await load();
    final now = DateTime.now();
    final pass = UserPass(
      id: 'CP' + now.millisecondsSinceEpoch.toString(),
      typeName: t.name,
      qrToken: _token(t.id),
      pricePaise: t.pricePaise,
      validFrom: now,
      validUntil: now.add(Duration(days: t.durationDays)),
    );
    list.insert(0, pass);
    await _save(list);
    return list;
  }

  static Future<void> activate(String id) async {
    final list = await load();
    for (final p in list) { if (p.id == id) p.active = true; }
    await _save(list);
  }

  static Future<void> _save(List<UserPass> l) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_key, UserPass.encodeList(l));
  }

  static String _token(String seed) {
    const c = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final r = Random();
    return seed.toUpperCase() + '-' +
        List.generate(20, (_) => c[r.nextInt(c.length)]).join();
  }
}
