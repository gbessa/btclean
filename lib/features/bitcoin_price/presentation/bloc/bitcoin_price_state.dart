part of 'bitcoin_price_bloc.dart';

@immutable
abstract class BitcoinPriceState extends Equatable {
  BitcoinPriceState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends BitcoinPriceState {}

class Loading extends BitcoinPriceState {}

class Loaded extends BitcoinPriceState {
  final BitcoinPrice bitcoinPrice;

  Loaded({@required this.bitcoinPrice}) : super([bitcoinPrice]);
}

class Error extends BitcoinPriceState {
  final String message;

  Error({@required this.message}) : super([message]);
}
