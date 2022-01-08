import 'dart:js';

import 'package:cripto/repositories/favorites_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesRepository(),
      child: MyApp(),
    ),
  );
}
