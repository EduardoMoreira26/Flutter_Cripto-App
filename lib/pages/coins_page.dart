import 'package:cripto/models/coin.dart';
import 'package:cripto/repositories/coin_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinsPage extends StatefulWidget {
  const CoinsPage({Key key}) : super(key: key);

  @override
  _CoinsPageState createState() => _CoinsPageState();
}

class _CoinsPageState extends State<CoinsPage> {
  @override
  Widget build(BuildContext context) {
    final tableCoins = CoinReposiroty.table;
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    List<Coin> selectedCoins = [];

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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            leading: SizedBox(
              child: Image.asset(tableCoins[index].icon),
              width: 30,
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
            selected: selectedCoins.contains(tableCoins[index]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selectedCoins.contains(tableCoins[index]))
                    ? selectedCoins.remove(tableCoins[index])
                    : selectedCoins.add(tableCoins[index]);
              print(tableCoins[index].name);
              });
            },
          );
        },
      ),
    );
  }
}
