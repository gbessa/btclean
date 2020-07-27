import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class BitcoinPrice extends Equatable {
  final String time;
  final double usdRate;
  final double eurRate;

  BitcoinPrice({
    @required this.time,
    @required this.usdRate,
    @required this.eurRate,
  });

  @override
  List<Object> get props => [time, usdRate, eurRate];
}
