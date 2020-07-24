import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:btclean/core/error/failures.dart';
import 'package:btclean/core/usecases/usecase.dart';
import 'package:btclean/core/util/input_converter.dart';
import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';
import 'package:btclean/features/bitcoin_price/domain/usecases/get_current_price.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'bitcoin_price_event.dart';
part 'bitcoin_price_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input';

class BitcoinPriceBloc extends Bloc<BitcoinPriceEvent, BitcoinPriceState> {
  final GetCurrentPrice getCurrentPrice;
  final InputConverter inputConverter;

  BitcoinPriceBloc({
    @required this.getCurrentPrice,
    @required this.inputConverter,
  })  : assert(getCurrentPrice != null),
        assert(inputConverter != null);

  @override
  BitcoinPriceState get initialState => Empty();

  @override
  Stream<BitcoinPriceState> mapEventToState(
    BitcoinPriceEvent event,
  ) async* {
    if (event is GetBitCoinCurrentPrice) {
      yield Loading();
      final failureOrBitcoin = await getCurrentPrice(NoParams());
      yield failureOrBitcoin.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (bitcoin) => Loaded(bitcoinPrice: bitcoin),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
