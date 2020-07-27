import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'package:btclean/core/error/exceptions.dart';
import 'package:btclean/features/bitcoin_price/data/models/bitcoin_price_model.dart';
import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';

abstract class BitcoinPriceRemoteDataSource {
  /// Call the https://api.coindesk.com/v1/bpi/currentprice.json endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<BitcoinPrice> getCurrentPrice();
}

const CURRENT_PRICE_ENDPOINT =
    'https://api.coindesk.com/v1/bpi/currentprice.json';

class BitcoinPriceRemoteDataSourceImpl implements BitcoinPriceRemoteDataSource {
  final http.Client client;

  BitcoinPriceRemoteDataSourceImpl({@required this.client});

  @override
  Future<BitcoinPrice> getCurrentPrice() async {
    final response = await client.get(CURRENT_PRICE_ENDPOINT);
    if (response.statusCode == 200) {
      return BitcoinPriceModel.fromCoindeskJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
