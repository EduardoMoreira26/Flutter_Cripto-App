import 'package:cripto/pages/coins_page.dart';
import 'package:cripto/pages/config_page.dart';
import 'package:cripto/pages/favorite_page.dart';
import 'package:cripto/pages/wallet_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int atualPage = 0;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: atualPage);
  }

  setAtualPage(page) {
    setState(() {
      atualPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          CoinsPage(),
          FavoritesPage(),
          CarteiraPage(),
          ConfigPage(),
        ],
        onPageChanged: setAtualPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: atualPage,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Todas"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favoritas"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Carteira"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Conta"),
        ],
        onTap: (page) {
          pageController.animateToPage(
            page,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
        // backgroundColor: Colors.indigo,
      ),
    );
  }
}
