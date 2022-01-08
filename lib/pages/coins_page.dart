import 'package:cripto/models/coin.dart';
import 'package:cripto/repositories/coin_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoedasPage extends StatefulWidget {
  MoedasPage({Key key}) : super(key: key);

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final table = CoinReposiroty.table;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Coin> selectedCoins = [];

  // appBarDinamica() {
  //   if (selectedCoins.isEmpty) {
  //     return AppBar(
  //       title: Text('Cripto Moedas'),
  //     );
  //   } else {
  //     return AppBar(
  //       leading: IconButton(
  //         icon: Icon(Icons.arrow_back),
  //         onPressed: () {
  //           setState(() {
  //             selectedCoins = [];
  //           });
  //         },
  //       ),
  //       // title: Text('${selectedCoins.length} selectedCoins'),
  //       backgroundColor: Colors.blueGrey[50],
  //       elevation: 1,
  //       iconTheme: IconThemeData(color: Colors.black87),
  //       textTheme: TextTheme(
  //         headline6: TextStyle(
  //           color: Colors.black87,
  //           fontSize: 20,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     );
  //   }
  // }

  // mostrarDetalhes(Moeda moeda) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => MoedasDetalhesPage(moeda: moeda),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int coin) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selectedCoins.contains(table[coin]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Image.asset(table[coin].icon),
                    width: 40,
                  ),
            title: Text(
              table[coin].name,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              real.format(table[coin].price),
              style: TextStyle(fontSize: 15),
            ),
            selected: selectedCoins.contains(table[coin]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selectedCoins.contains(table[coin]))
                    ? selectedCoins.remove(table[coin])
                    : selectedCoins.add(table[coin]);
              });
            },
            // onTap: () => mostrarDetalhes(table[coin]),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, ___) => Divider(),
        itemCount: table.length,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: selectedCoins.isNotEmpty
      //     ? FloatingActionButton.extended(
      //         onPressed: () {},
      //         icon: Icon(Icons.star),
      //         label: Text(
      //           'FAVORITAR',
      //           style: TextStyle(
      //             letterSpacing: 0,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       )
      //     : null,
    );
  }
}
