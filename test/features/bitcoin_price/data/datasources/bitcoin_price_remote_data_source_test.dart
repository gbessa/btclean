import 'dart:convert';

import 'package:btclean/core/error/exceptions.dart';
import 'package:btclean/features/bitcoin_price/data/datasources/bitcoin_price_remote_data_source.dart';
import 'package:btclean/features/bitcoin_price/data/models/bitcoin_price_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import '../../../../core/fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  BitcoinPriceRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = BitcoinPriceRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(fixture('coindesk_currentprice.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group(
    'getCurrentBitcoinPrice',
    () {
      final tBitcoinPriceModel = BitcoinPriceModel.fromCoindeskJson(
          json.decode(fixture('coindesk_currentprice.json')));

      test(
        'should perform a GET request on a URL ',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          dataSource.getCurrentPrice();
          // assert
          verify(mockHttpClient.get(CURRENT_PRICE_ENDPOINT));
        },
      );

      test(
        'should return BitcoinPrice when the response is 200',
        () async {
          // arrange
          setUpMockHttpClientSuccess200();
          // act
          final result = await dataSource.getCurrentPrice();
          // assert
          expect(result, equals(tBitcoinPriceModel));
        },
      );

      test(
        'should return throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          setUpMockHttpClientFailure404();
          // act
          final call = dataSource.getCurrentPrice;
          // assert
          expect(() => call(), throwsA(TypeMatcher<ServerException>()));
        },
      );
    },
  );
}
