import 'package:cripto/models/coin.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailsCoinPage extends StatefulWidget {
  Coin coin;

  DetailsCoinPage({
    Key key,
    this.coin,
  }) : super(key: key);

  @override
  _DetailsCoinPageState createState() => _DetailsCoinPageState();
}

class _DetailsCoinPageState extends State<DetailsCoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.name),
      ),
    );
  }
}
