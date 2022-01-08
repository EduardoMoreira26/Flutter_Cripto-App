import 'dart:collection';

import 'package:cripto/models/coin.dart';
import 'package:flutter/material.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Coin> _list = [];

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
