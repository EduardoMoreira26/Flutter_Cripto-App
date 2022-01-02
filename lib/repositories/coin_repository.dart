import 'package:cripto/models/coin.dart';

class CoinReposiroty {
  static List<Coin> table = [
    Coin(
      icon: 'images/bitcoin.png',
      name: 'Bitcoin',
      initials: 'BTC',
      price: 236603.01,
    ),
    Coin(
      icon: 'images/ADA.png',
      name: 'ADA',
      initials: 'ADA',
      price: 121.20,
    ),
    Coin(
      icon: 'images/ethereum.png',
      name: 'Ethereum',
      initials: 'ETHER',
      price: 552.53,
    ),
    Coin(
      icon: 'images/litecoin.png',
      name: 'LiteCoin',
      initials: 'LC',
      price: 365.21,
    ),
    Coin(
      icon: 'images/USDC.png',
      name: 'USDC',
      initials: 'USDC',
      price: 11.11,
    ),
    Coin(
      icon: 'images/xrp.png',
      name: 'XRP',
      initials: 'XRP',
      price: 3.36,
    ),
  ];
}
