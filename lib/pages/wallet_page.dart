import 'package:cripto/repositories/account__reposiotry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Container();
  }
}