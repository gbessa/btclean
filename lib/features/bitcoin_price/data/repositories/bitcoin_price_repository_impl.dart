import 'package:btclean/core/error/exceptions.dart';
import 'package:btclean/core/error/failures.dart';
import 'package:btclean/core/platform/network_info.dart';
import 'package:btclean/features/bitcoin_price/data/datasources/bitcoin_price_local_data_source.dart';
import 'package:btclean/features/bitcoin_price/data/datasources/bitcoin_price_remote_data_source.dart';
import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';
import 'package:btclean/features/bitcoin_price/domain/repositories/bitcoin_price_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

class BitcoinPriceRepositoryImpl implements BitCoinPriceRepository {
  final BitcoinPriceRemoteDataSource remoteDataSource;
  final BitcoinPriceLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BitcoinPriceRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, BitcoinPrice>> getCurrentPrice() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBitcoinPrice = await remoteDataSource.getCurrentPrice();
        localDataSource.cacheBitcoinPrice(remoteBitcoinPrice);
        return Right(remoteBitcoinPrice);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localBitcoinPrice = await localDataSource.getLastBitcoinPrice();
        return Right(localBitcoinPrice);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
