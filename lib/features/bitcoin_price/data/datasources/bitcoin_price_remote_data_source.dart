import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';

abstract class BitcoinPriceRemoteDataSource {
  /// Call the https://api.coindesk.com/v1/bpi/currentprice.json endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<BitcoinPrice> getCurrentPrice();
}
