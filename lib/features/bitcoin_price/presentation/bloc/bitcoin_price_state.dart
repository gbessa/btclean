part of 'bitcoin_price_bloc.dart';

@immutable
abstract class BitcoinPriceState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends BitcoinPriceState {}

class Loading extends BitcoinPriceState {}

class Loaded extends BitcoinPriceState {
  final BitcoinPrice bitcoinPrice;

  Loaded({@required this.bitcoinPrice});
}

class Error extends BitcoinPriceState {
  final String message;

  Error({@required this.message});
}
