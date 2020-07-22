import 'dart:convert';

import 'package:btclean/features/bitcoin_price/data/models/bitcoin_price_model.dart';
import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../core/fixtures/fixture_reader.dart';

void main() {
  final tBitcoinPriceModel = BitcoinPriceModel(
    time: '2020-07-22T15:00:00+00:00',
    usdRate: 9358.1201,
    eurRate: 8109.7656,
  );

  test(
    'should be a subclass of BitcoinPrice entity',
    () async {
      // assert
      expect(tBitcoinPriceModel, isA<BitcoinPrice>());
    },
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid model',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('coindesk_currentprice.json'));
          // act
          final result = BitcoinPriceModel.fromJson(jsonMap);
          // assert
          expect(result, tBitcoinPriceModel);
        },
      );
    },
  );
}
