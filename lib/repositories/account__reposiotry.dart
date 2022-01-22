import 'package:cripto/database/db.dart';
import 'package:cripto/models/coin.dart';
import 'package:cripto/models/historico.dart';
import 'package:cripto/models/position.dart';
import 'package:cripto/repositories/coin_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class AccountReposiotry extends ChangeNotifier {
   Database db;
  List<Position> _carteira = [];
  List<Historico> _historico = [];
  double _saldo = 0;

  get saldo => _saldo;
  List<Position> get carteira => _carteira;
  List<Historico> get historico => _historico;

  ContaRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getSaldo();
    await _getCarteira();
    await _getHistorico();
  }

  _getHistorico() async {
    _historico = [];
    List operacoes = await db.query('historico');
    operacoes.forEach((operacao) {
      Coin moeda = CoinReposiroty.table.firstWhere(
        (m) => m.initials == operacao['sigla'],
      );
      _historico.add(Historico(
        dataOperacao:
            DateTime.fromMillisecondsSinceEpoch(operacao['data_operacao']),
        tipoOperacao: operacao['tipo_operacao'],
        moeda: moeda,
        valor: operacao['valor'],
        quantidade: double.parse(operacao['quantidade']),
      ));
    });
    notifyListeners();
  }

  _getSaldo() async {
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor,
    });
    _saldo = valor;
    notifyListeners();
  }

  _getCarteira() async {
    _carteira = [];
    List posicoes = await db.query('carteira');
    posicoes.forEach((posicao) {
      Coin moeda = CoinReposiroty.table.firstWhere(
        (m) => m.initials == posicao['sigla'],
      );
      _carteira.add(Position(
        coin: moeda,
        quantidade: double.parse(posicao['quantidade']),
      ));
    });
    notifyListeners();
  }

  comprar(Coin moeda, double valor) async {
    db = await DB.instance.database;

    await db.transaction((txn) async {
      // Verificar se a moeda já foi comprada
      final posicaoMoeda = await txn.query(
        'carteira',
        where: 'sigla = ?',
        whereArgs: [moeda.initials],
      );
      // Se não tem a moeda ainda, insert
      if (posicaoMoeda.isEmpty) {
        await txn.insert('carteira', {
          'sigla': moeda.initials,
          'moeda': moeda.name,
          'quantidade': (valor / moeda.price).toString()
        });
      } else {
        final atual = double.parse(posicaoMoeda.first['quantidade'].toString());
        await txn.update(
          'carteira',
          {'quantidade': ((valor / moeda.price) + atual).toString()},
          where: 'sigla = ?',
          whereArgs: [moeda.initials],
        );
      }

      // Inserir o histórico
      await txn.insert('historico', {
        'sigla': moeda.initials,
        'moeda': moeda.name,
        'quantidade': (valor / moeda.price).toString(),
        'valor': valor,
        'tipo_operacao': 'compra',
        'data_operacao': DateTime.now().millisecondsSinceEpoch
      });

      await txn.update('conta', {'saldo': saldo - valor});
    });

    await _initRepository();
    notifyListeners();
  }
}