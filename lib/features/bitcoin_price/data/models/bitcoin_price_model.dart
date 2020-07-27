import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';
import 'package:meta/meta.dart';

class BitcoinPriceModel extends BitcoinPrice {
  BitcoinPriceModel({
    @required time,
    @required usdRate,
    @required eurRate,
  }) : super(time: time, usdRate: usdRate, eurRate: eurRate);

  factory BitcoinPriceModel.fromCoindeskJson(Map<String, dynamic> json) {
    return BitcoinPriceModel(
      time: json['time']['updatedISO'],
      usdRate: double.parse(json['bpi']['USD']['rate'].replaceAll(',', '')),
      eurRate: double.parse(json['bpi']['EUR']['rate'].replaceAll(',', '')),
    );
  }

  factory BitcoinPriceModel.fromJson(Map<String, dynamic> json) {
    return BitcoinPriceModel(
      time: json['time'],
      usdRate: json['usdRate'],
      eurRate: json['eurRate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'usdRate': usdRate,
      'eurRate': eurRate,
    };
  }

  @override
  List<Object> get props => [];
}
