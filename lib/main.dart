import 'dart:js';

import 'package:cripto/configs/app_settings.dart';
import 'package:cripto/repositories/favorites_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppSettings(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritesRepository(),
        ),
      ],
      child: MyApp(),
    ),
  );
}
