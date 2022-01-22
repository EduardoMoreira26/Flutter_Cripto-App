import 'package:cripto/configs/app_settings.dart';
import 'package:cripto/models/position.dart';
import 'package:cripto/repositories/account__reposiotry.dart';
import 'package:fl_chart/fl_chart.dart';
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

  double graficoValor = 0;
  String graficoLabel = '';
  List<Position> wallet = [];

  @override
  Widget build(BuildContext context) {
    account = context.watch<AccountReposiotry>();
    final loc = context.read<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    saldo = account.saldo;

    setTotalWallet();

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

  setTotalWallet() {
    final listWallet = account.wallet;
    setState(() {
      totalWallet = account.saldo;
      for (var position in listWallet) {
        totalWallet = position.coin.price * position.quantidade;
      }
    });
  }

  setGraphicData(index) {
    if (index < 0) return;

    if (index == wallet.length) {
      graficoLabel = 'Saldo';
      graficoValor = account.saldo;
    } else {
      graficoLabel = wallet[index].coin.name;
      graficoValor = wallet[index].coin.price * wallet[index].quantidade;
    }
  }

  loadWallet() {
    setGraphicData(index);
    wallet = account.wallet;

    final widhtList = wallet.length + 1;

    return List.generate(widhtList, (i) {
      final isTouched = i == index;
      final isSaldo = i == widhtList - 1;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      final color = isTouched ? Colors.tealAccent : Colors.tealAccent[400];

      double porcentagem = 0;
      if (!isSaldo) {
        porcentagem = wallet[i].coin.price * wallet[i].quantidade / totalWallet;
      } else {
        porcentagem = (account.saldo > 0) ? account.saldo / totalWallet : 0;
      }
      porcentagem *= 100;

      return PieChartSectionData(
        color: color,
        value: porcentagem,
        title: '${porcentagem.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      );
    });
  }

  loadGraphic() {
    return (account.saldo <= 0)
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 50,
                    centerSpaceRadius: 120,
                    sections: loadWallet(),
                    pieTouchData: PieTouchData(
                      touchCallback: (touch) => setState(() {
                        index = touch.touchedSection.touchedSectionIndex;
                        setGraphicData(index);
                      }),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    graficoLabel,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  Text(
                    real.format(
                      graficoValor,
                    ),
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ],
              )
            ],
          );
  }
}
