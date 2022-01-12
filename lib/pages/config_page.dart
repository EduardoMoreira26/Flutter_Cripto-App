import 'package:cripto/configs/app_settings.dart';
import 'package:cripto/repositories/account__reposiotry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfigPage extends StatefulWidget {
  ConfigPage({Key key}) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    final conta = context.watch<AccountReposiotry>();
    final loc = context.watch<AppSettings>().locale;
    NumberFormat real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);

     return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ListTile(
              title: Text('Saldo'),
              subtitle: Text(
                real.format(conta.saldo),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.indigo,
                ),
              ),
              trailing:
                  IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
            ),
            Divider(),
          ],
        ),
      ),
    );

  }
}
