import 'dart:collection';
import 'package:cripto/adapters/coin_hive_adapter.dart';
import 'package:cripto/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Coin> _list = [];
  LazyBox box;

  FavoritesRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavorites();
  }

  _openBox() async {
    Hive.registerAdapter(CoinHiveAdapter());
  }

  _readFavorites() async {}

  UnmodifiableListView<Coin> get list => UnmodifiableListView(_list);

  saveAll(List<Coin> coins) {
    coins.forEach((coin) {
      if (!_list.contains(coin)) _list.add(coin);
    });

    notifyListeners();
  }

  remove(Coin coin) {
    _list.remove(coin);
    notifyListeners();
  }
}
