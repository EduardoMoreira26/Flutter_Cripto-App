import 'package:cripto/models/coin.dart';

class Historico {
  DateTime dataOperacao;
  String tipoOperacao;
  Coin moeda;
  double valor;
  double quantidade;

  Historico({
    this.dataOperacao,
    this.tipoOperacao,
    this.moeda,
    this.valor,
    this.quantidade,
  });
}
