import 'package:btclean/core/error/failures.dart';
import 'package:btclean/core/usecases/usecase.dart';
import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';
import 'package:btclean/features/bitcoin_price/domain/repositories/bitcoin_price_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentPrice implements Usecase<BitcoinPrice, NoParams> {
  final BitCoinPriceRepository repository;

  GetCurrentPrice(this.repository);

  @override
  Future<Either<Failure, BitcoinPrice>> call(NoParams noParams) async {
    return await repository.getCurrentPrice();
  }
}
