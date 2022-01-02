import 'package:cripto/repositories/coin_repository.dart';
import 'package:flutter/material.dart';

class CoinsPage extends StatelessWidget {
  const CoinsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tableCoins = CoinReposiroty.table;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Moedas'),
        ),
      ),
      body: ListView.separated(
        itemCount: tableCoins.length, 
        padding: EdgeInsets.all(16),
        separatorBuilder: (_,__) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(tableCoins[index].icon),
            title: Text(tableCoins[index].name),
            trailing: Text(tableCoins[index].price.toString()),
          );
        },
      ),
    );
  }
}
