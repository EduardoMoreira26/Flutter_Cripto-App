import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  SharedPreferences _prefs;

  Map<String, String> locale = {
    'locale': 'pt_BR',
    'name': 'R\$',
  };

  AppSettigns() {
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _readLocale() async {
    final local = _prefs.getString('local') ?? 'pt_BR';
    final name = _prefs.getString('name') ?? 'R\$';

    locale = {
      'locale': local,
      'name': name,
    };
    notifyListeners();
  }

  setLocale(String local, String name) async {
    await _prefs.setString('locale', local);
    await _prefs.setString('name', name);
    await _readLocale();
  }
}
