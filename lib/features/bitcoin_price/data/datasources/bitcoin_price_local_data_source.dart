import 'package:btclean/features/bitcoin_price/data/models/bitcoin_price_model.dart';
import 'package:btclean/features/bitcoin_price/domain/entities/bitcoin_price.dart';

abstract class BitcoinPriceLocalDataSource {
  /// Gets the cached [BitcoinPriceModel] which was gotten last time when the user had internet connection
  ///
  /// Throws [CacheException] if no cache was found
  Future<BitcoinPriceModel> getLastBitcoinPrice();

  Future<void> cacheBitcoinPrice(BitcoinPrice bitcoinPriceToCache);
}
