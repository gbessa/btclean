import 'package:btclean/core/error/failures.dart';
import 'package:btclean/core/usecases/usecase.dart';
import 'package:btclean/core/util/input_converter.dart';
import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';
import 'package:btclean/features/bitcoin_price/domain/usecases/get_current_price.dart';
import 'package:btclean/features/bitcoin_price/presentation/bloc/bitcoin_price_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetCurrentPrice extends Mock implements GetCurrentPrice {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  BitcoinPriceBloc bloc;
  MockGetCurrentPrice mockGetCurrentPrice;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetCurrentPrice = MockGetCurrentPrice();
    mockInputConverter = MockInputConverter();
    bloc = BitcoinPriceBloc(
        getCurrentPrice: mockGetCurrentPrice,
        inputConverter: mockInputConverter);
  });

  test(
    'initialState should be Empty',
    () async {
      // assert
      expect(bloc.initialState, equals(Empty()));
    },
  );

  group('GetBitCoinLastPrice', () {
    final tBitcoinPrice = BitcoinPrice(time: 'now', usdRate: 3.9, eurRate: 3.2);

    test(
      'should get data from the GetBitCoinLastPrice usecase',
      () async {
        // arrange
        when(mockGetCurrentPrice(any))
            .thenAnswer((_) async => Right(tBitcoinPrice));
        // act
        bloc.dispatch(GetBitCoinCurrentPrice());
        await untilCalled(mockGetCurrentPrice(any));
        // assert
        verify(mockGetCurrentPrice(NoParams()));
      },
    );

    test(
      'should emit [Loading, Loaded] when data gotten successfully]',
      () async {
        // arrange
        when(mockGetCurrentPrice(any))
            .thenAnswer((_) async => Right(tBitcoinPrice));
        // assert
        final expected = [
          Empty(),
          Loading(),
          Loaded(bitcoinPrice: tBitcoinPrice)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetBitCoinCurrentPrice());
      },
    );

    test(
      'should emit [Loading, Error] when data gotten successfully]',
      () async {
        // arrange
        when(mockGetCurrentPrice(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetBitCoinCurrentPrice());
      },
    );

    test(
      'should emit [Loading, Error] with proper message for the error]',
      () async {
        // arrange
        when(mockGetCurrentPrice(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert
        final expected = [
          Empty(),
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        // act
        bloc.dispatch(GetBitCoinCurrentPrice());
      },
    );
  });
}
