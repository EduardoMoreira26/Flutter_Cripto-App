import 'package:flutter/material.dart';

class CoinsPage extends StatelessWidget {
  const CoinsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Moedas'),
        ),
      ),
      body: Center(
        child: Text('Olá MOedas'),
      ),
    );
  }
}
