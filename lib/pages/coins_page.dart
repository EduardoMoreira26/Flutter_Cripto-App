import 'package:cripto/repositories/coin_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinsPage extends StatelessWidget {
  const CoinsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tableCoins = CoinReposiroty.table;
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Moedas'),
        ),
      ),
      body: ListView.separated(
        itemCount: tableCoins.length,
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
              child: Image.asset(tableCoins[index].icon),
              width: 40,
            ),
            title: Text(
              tableCoins[index].name,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              real.format(tableCoins[index].price),
            ),
            selected: false,
          );
        },
      ),
    );
  }
}
