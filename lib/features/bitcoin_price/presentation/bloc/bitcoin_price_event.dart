part of 'bitcoin_price_bloc.dart';

@immutable
abstract class BitcoinPriceEvent extends Equatable {
  BitcoinPriceEvent();
}

class GetBitCoinCurrentPrice extends BitcoinPriceEvent {}
