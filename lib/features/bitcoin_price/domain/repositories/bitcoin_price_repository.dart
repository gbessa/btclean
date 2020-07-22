import 'package:btclean/core/error/failures.dart';
import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';
import 'package:dartz/dartz.dart';

abstract class BitCoinPriceRepository {
  Future<Either<Failure, BitcoinPrice>> getCurrentPrice();
}
