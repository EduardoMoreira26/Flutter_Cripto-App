import 'package:cripto/configs/app_settings.dart';
import 'package:cripto/models/coin.dart';
import 'package:cripto/pages/details_coin_page.dart';
import 'package:cripto/repositories/coin_repository.dart';
import 'package:cripto/repositories/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CoinsPage extends StatefulWidget {
  CoinsPage({Key key}) : super(key: key);

  @override
  _CoinsPageState createState() => _CoinsPageState();
}

class _CoinsPageState extends State<CoinsPage> {
  final table = CoinReposiroty.table;
  // NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  NumberFormat real;
  Map<String, String> loc;
  List<Coin> selectedCoins = [];
  FavoritesRepository favoritesRepository;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
          leading: Icon(Icons.swap_vert),
          title: Text('Usar $locale'),
          onTap: () {
            context.read<AppSettings>().setLocale(locale, name);
            Navigator.pop(context);
          },
        )),
      ],
    );
  }

  appBarDinamica() {
    if (selectedCoins.isEmpty) {
      return AppBar(
        title: Center(child: Text('Cripto Moedas')),
        actions: [
          changeLanguageButton(),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selectedCoins = [];
            });
          },
        ),
        title: Text(
            '${selectedCoins.length} ${selectedCoins.length > 1 ? 'selecionadas' : 'selecionada'} '),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  datailsCoin(Coin coin) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsCoinPage(coin: coin),
      ),
    );
  }

  cleanSelectedCoins() {
    setState(() {
      selectedCoins = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    favoritesRepository = Provider.of<FavoritesRepository>(context);
    readNumberFormat();

    return Scaffold(
      appBar: appBarDinamica(),
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
            title: Row(
              children: [
                Text(
                  table[coin].name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (favoritesRepository.list.any((favoriteCoin) =>
                    favoriteCoin.initials == table[coin].initials))
                  Icon(Icons.star, color: Colors.amber, size: 12),
              ],
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
            onTap: () => datailsCoin(table[coin]),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, ___) => Divider(),
        itemCount: table.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selectedCoins.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritesRepository.saveAll(selectedCoins);
                cleanSelectedCoins();
              },
              icon: Icon(Icons.star),
              label: Text(
                'FAVORITAR',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
