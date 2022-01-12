import 'dart:collection';
import 'package:cripto/adapters/coin_hive_adapter.dart';
import 'package:cripto/models/coin.dart';
import 'package:flutter/material.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Coin> _list = [];
  // LazyBox box;

  // FavoritesRepository() {
  //   _startRepository();
  // }

  // _startRepository() async {
  //   await _openBox();
  //   await _readFavorites();
  // }

  // _openBox() async {
  //   Hive.registerAdapter(CoinHiveAdapter());
  //   box = await Hive.openLazyBox<Coin>('favorites_coins');
  // }

  // _readFavorites() async {
  //   box.keys.forEach((coin) async {
  //     Coin m = await box.get(coin);
  //     _list.add(m);
  //     notifyListeners();
  //   });
  // }

  UnmodifiableListView<Coin> get list => UnmodifiableListView(_list);

  saveAll(List<Coin> coins) {
    coins.forEach((coin) {
      if (!_list.contains(coin)) _list.add(coin);
    });

    notifyListeners();
  }

  remove(Coin coin) {
    _list.remove(coin);
    // box.delete(coin.initials);
    notifyListeners();
  }
}
