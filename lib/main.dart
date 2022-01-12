import 'package:cripto/configs/app_settings.dart';
import 'package:cripto/configs/hive_config.dart';
import 'package:cripto/my_app.dart';
import 'package:cripto/repositories/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await HiveConfig.start();

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritesRepository()),
      ],
      child: MyApp(),
    ),
  );
}
