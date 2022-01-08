import 'package:cripto/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _value = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.coin.name)),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(widget.coin.icon),
                    width: 50,
                  ),
                  Container(width: 10),
                  Text(
                    real.format(widget.coin.price),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _form,
              child: TextFormField(
                controller: _value,
                style: TextStyle(fontSize: 22),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    'Reais',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
