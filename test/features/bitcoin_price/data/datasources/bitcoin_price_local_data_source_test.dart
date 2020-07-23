import 'dart:convert';

import 'package:btclean/core/error/exceptions.dart';
import 'package:btclean/features/bitcoin_price/data/datasources/bitcoin_price_local_data_source.dart';
import 'package:btclean/features/bitcoin_price/data/models/bitcoin_price_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../core/fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  BitcoinPriceLocalDataSource dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = BitcoinPriceLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastCachedPrice', () {
    final tBitcoinPriceModel = BitcoinPriceModel.fromJson(
        json.decode(fixture('cached_lastprice.json')));

    test(
      'should return BitcoinPrice from SharedPreferences, when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('cached_lastprice.json'));
        // act
        final result = await dataSource.getLastBitcoinPrice();
        // assert
        verify(mockSharedPreferences.getString(CACHED_BITCOIN_LASTPRICE));
        expect(result, equals(tBitcoinPriceModel));
      },
    );

    test(
      'should throw CacheException when there is no data in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getLastBitcoinPrice;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheLastPrice', () {
    final tBitcoinPriceModel =
        BitcoinPriceModel(time: 'now', usdRate: 3.9, eurRate: 3.3);

    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cacheBitcoinPrice(tBitcoinPriceModel);
        // assert
        final expectedJsonString = json.encode(tBitcoinPriceModel.toJson());
        verify(mockSharedPreferences.setString(
            CACHED_BITCOIN_LASTPRICE, expectedJsonString));
      },
    );
  });
}
