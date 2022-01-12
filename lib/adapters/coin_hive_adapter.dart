// import 'package:cripto/models/coin.dart';
// import 'package:hive/hive.dart';

// class CoinHiveAdapter extends TypeAdapter<Coin> {
//   @override
//   final typeId = 0;

//   @override
//   Coin read(BinaryReader reader) {
//     return Coin(
//       icon: reader.readString(),
//       name: reader.readString(),
//       initials: reader.readString(),
//       price: reader.readDouble(),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Coin obj) {
//     writer.writeString(obj.icon);
//     writer.writeString(obj.name);
//     writer.writeString(obj.initials);
//     writer.writeDouble(obj.price);
//   }
// }