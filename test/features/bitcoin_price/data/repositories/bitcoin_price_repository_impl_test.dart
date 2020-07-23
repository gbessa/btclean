import 'package:btclean/core/error/exceptions.dart';
import 'package:btclean/core/error/failures.dart';
import 'package:btclean/core/network/network_info.dart';
import 'package:btclean/features/bitcoin_price/data/datasources/bitcoin_price_local_data_source.dart';
import 'package:btclean/features/bitcoin_price/data/datasources/bitcoin_price_remote_data_source.dart';
import 'package:btclean/features/bitcoin_price/data/models/bitcoin_price_model.dart';
import 'package:btclean/features/bitcoin_price/data/repositories/bitcoin_price_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock
    implements BitcoinPriceRemoteDataSource {}

class MockLocalDataSource extends Mock implements BitcoinPriceLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  BitcoinPriceRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = BitcoinPriceRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  void runTestsOnLine(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffLine(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getCurrentPrice', () {
    final tBitcoinPriceModel =
        BitcoinPriceModel(time: 'now', usdRate: 1.0, eurRate: 2.0);
    final tBitcoinPrice = tBitcoinPriceModel;

    test(
      'should check if there is internet connection',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getCurrentPrice();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnLine(() {
      test('should return remote data when the call is success', () async {
        // arrange
        when(mockRemoteDataSource.getCurrentPrice())
            .thenAnswer((_) async => tBitcoinPriceModel);
        // act
        final result = await repository.getCurrentPrice();
        // assert
        expect(result, equals(Right(tBitcoinPrice)));
      });

      test('should cache the data locally when the call is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getCurrentPrice())
            .thenAnswer((_) async => tBitcoinPriceModel);
        // act
        await repository.getCurrentPrice();
        // assert
        verify(mockLocalDataSource.cacheBitcoinPrice(tBitcoinPriceModel));
      });

      test('should return server failure when the call is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getCurrentPrice())
            .thenThrow(ServerException());
        // act
        final result = await repository.getCurrentPrice();
        // assert
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffLine(() {
      test(
          'should return locally cached last data when the cache data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastBitcoinPrice())
            .thenAnswer((_) async => tBitcoinPriceModel);
        // act
        final result = await repository.getCurrentPrice();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastBitcoinPrice());
        expect(result, equals(Right(tBitcoinPriceModel)));
      });

      test('should return CacheFailure when the cache data is present',
          () async {
        // arrange
        when(mockLocalDataSource.getLastBitcoinPrice())
            .thenThrow(CacheException());
        // act
        final result = await repository.getCurrentPrice();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastBitcoinPrice());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
