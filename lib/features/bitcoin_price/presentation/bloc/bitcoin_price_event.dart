part of 'bitcoin_price_bloc.dart';

@immutable
abstract class BitcoinPriceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetBitCoinCurrentPrice extends BitcoinPriceEvent {}
