import 'package:cripto/database/db.dart';
import 'package:cripto/models/position.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ContaRepository extends ChangeNotifier {
  Database db;
  List<Position> _wallet = [];
  double _saldo = 0;

  get saldo => _saldo;
  List<Position> get wallet => _wallet;

  ContaRepository()  {
     _initRepository();
  }

  _initRepository() async {
    await _getSaldo();
  }

  _getSaldo() async {
    db = await DB.instance.database;

    List conta = await db.query('conta', limit: 10);
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  setSaldo(double value) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': value,
    });
    _saldo = value;
    notifyListeners();
  }
}