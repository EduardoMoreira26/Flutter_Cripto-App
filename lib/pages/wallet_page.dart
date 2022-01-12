import 'package:cripto/configs/app_settings.dart';
import 'package:cripto/repositories/account__reposiotry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletPage extends StatefulWidget {
  WalletPage({Key key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int index = 0;
  double totalWallet = 0;
  double saldo = 0;
  NumberFormat real;
  AccountReposiotry account;

  @override
  Widget build(BuildContext context) {
    account = context.watch<AccountReposiotry>();
    final loc = context.read<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    saldo = account.saldo;

    // setTotalCarteira();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 48, bottom: 24),
              child: Text(
                'Valor da Carteira',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Text(
              real.format(totalWallet),
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.5,
              ),
            ),
            loadGraphic(),
          ],
        ),
      ),
    );
  }
  
  loadGraphic() {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 200,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

}

