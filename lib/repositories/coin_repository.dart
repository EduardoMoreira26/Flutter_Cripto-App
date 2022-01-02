import 'package:cripto/models/coin.dart';

class CoinReposiroty {
  static List<Coin> table = [
    Coin(
      icon: 'images/bitcoin.png',
      name: 'Bitcoin',
      initials: 'BTC',
      price: 236603.00,
    ),
    Coin(
      icon: 'images/ADA.png',
      name: 'ADA',
      initials: 'ADA',
      price: 121.00,
    ),
    Coin(
      icon: 'images/ethereum.png',
      name: 'Ethereum',
      initials: 'ETHER',
      price: 552.00,
    ),
    Coin(
      icon: 'images/litecoin.png',
      name: 'LiteCoin',
      initials: 'LC',
      price: 365.00,
    ),
    Coin(
      icon: 'images/USDC.png',
      name: 'USDC',
      initials: 'USDC',
      price: 11.00,
    ),
    Coin(
      icon: 'images/xrp.png',
      name: 'XRP',
      initials: 'XRP',
      price: 3.00,
    ),
  ];
}
