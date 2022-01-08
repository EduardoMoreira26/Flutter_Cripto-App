import 'package:cripto/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  double qtd = 0;

  buyCoin() {
    if (_form.currentState.validate()) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Compra realizada com sucesso!'),
      ));
    }
  }

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
            (qtd > 0)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Text(
                        '$qtd ${widget.coin.initials}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.05),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(bottom: 24),
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Informe o valor da compra';
                  } else if (double.parse(value) < 50) {
                    return 'Compra mínima é R\$ 50,00';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(
                    () {
                      qtd = (value.isEmpty)
                          ? 0
                          : double.parse(value) / widget.coin.price;
                    },
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: buyCoin,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Comprar',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
