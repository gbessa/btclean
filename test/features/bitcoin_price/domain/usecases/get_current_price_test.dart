import 'package:btclean/core/usecases/usecase.dart';
import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';
import 'package:btclean/features/bitcoin_price/domain/repositories/bitcoin_price_repository.dart';
import 'package:btclean/features/bitcoin_price/domain/usecases/get_current_price.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBitCoinPriceRepository extends Mock
    implements BitCoinPriceRepository {}

void main() {
  GetCurrentPrice usecase;
  MockBitCoinPriceRepository mockBitCoinPriceRepository;

  setUp(() {
    mockBitCoinPriceRepository = MockBitCoinPriceRepository();
    usecase = GetCurrentPrice(mockBitCoinPriceRepository);
  });

  final tBitCoinPrice = BitcoinPrice(
      time: '2020-07-21T17:18:00+00:00', eurRate: 3.10, usdRate: 3.68);

  test(
    'should get current price from repository',
    () async {
      // arrange
      when(mockBitCoinPriceRepository.getCurrentPrice())
          .thenAnswer((_) async => Right(tBitCoinPrice));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tBitCoinPrice));
      verify(mockBitCoinPriceRepository.getCurrentPrice());
      verifyNoMoreInteractions(mockBitCoinPriceRepository);
    },
  );
}
