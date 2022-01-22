import 'package:cripto/configs/app_settings.dart';
import 'package:cripto/models/position.dart';
import 'package:cripto/repositories/account__reposiotry.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CarteiraPage extends StatefulWidget {
  CarteiraPage({Key key}) : super(key: key);

  @override
  _CarteiraPageState createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  int index = 0;
  double totalCarteira = 0;
  double saldo;
  NumberFormat real;
  AccountReposiotry conta;

  double graficoValor = 0;
  String graficoLabel = '';
  List<Position> carteira = [];

  @override
  Widget build(BuildContext context) {
    conta = context.watch<AccountReposiotry>();
    final loc = context.read<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    saldo = conta.saldo;

    setTotalCarteira();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 48),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 48, bottom: 8),
              child: Text(
                'Valor da Carteira',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Text(
              real.format(totalCarteira),
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.5,
              ),
            ),
            loadGrafico(),
            loadHistorico(),
          ],
        ),
      ),
    );
  }

  loadHistorico() {
    final historico = conta.historico;
    final date = DateFormat('dd/MM/yyyy - hh:mm');

    List<Widget> widgets = [];

    for (var operacao in historico) {
      widgets.add(ListTile(
        
        title: Text(operacao.moeda.name),
        subtitle: Text(date.format(operacao.dataOperacao)),
        trailing: Text(
          real.format(
            (operacao.moeda.price * operacao.quantidade),
          ),
          style: TextStyle(color: Colors.teal, fontSize: 16),
        ),
      ));
      widgets.add(Divider());
    }

    return Column(
      children: widgets,
    );
  }

  setTotalCarteira() {
    final carteiraList = conta.carteira;

    setState(() {
      totalCarteira = conta.saldo;
      for (var posicao in carteiraList) {
        totalCarteira += posicao.coin.price * posicao.quantidade;
      }
    });
  }

  loadGrafico() {
    return (conta.saldo <= 0)
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
                    sectionsSpace: 5,
                    centerSpaceRadius: 110,
                    sections: loadCarteira(),
                    pieTouchData: PieTouchData(
                      touchCallback: (touch) => setState(() {
                        index = touch.touchedSection.touchedSectionIndex;
                        setGraficoDados(index);
                      }),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    graficoLabel,
                    style: TextStyle(fontSize: 20, color: Colors.teal),
                  ),
                  Text(
                    real.format(graficoValor),
                    style: TextStyle(fontSize: 28),
                  ),
                ],
              )
            ],
          );
  }

  List<PieChartSectionData> loadCarteira() {
    setGraficoDados(index);
    carteira = conta.carteira;
    final tamanhoLista = carteira.length + 1;

    return List.generate(tamanhoLista, (i) {
      final isTouched = i == index;
      final isSaldo = i == tamanhoLista - 1;
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      final color = isTouched ? Colors.tealAccent : Colors.tealAccent[400];

      double porcentagem = 0;
      if (!isSaldo) {
        porcentagem =
            carteira[i].coin.price * carteira[i].quantidade / totalCarteira;
      } else {
        porcentagem = (conta.saldo > 0) ? conta.saldo / totalCarteira : 0;
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

  setGraficoDados(index) {
    if (index < 0) return;

    if (index == carteira.length) {
      graficoLabel = 'Saldo';
      graficoValor = conta.saldo;
    } else {
      graficoLabel = carteira[index].coin.name;
      graficoValor = carteira[index].coin.price * carteira[index].quantidade;
    }
  }
}
