import 'dart:convert';

import 'package:btclean/core/error/exceptions.dart';
import 'package:btclean/features/bitcoin_price/data/models/bitcoin_price_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BitcoinPriceLocalDataSource {
  /// Gets the cached [BitcoinPriceModel] which was gotten last time when the user had internet connection
  ///
  /// Throws [CacheException] if no cache was found
  Future<BitcoinPriceModel> getLastBitcoinPrice();

  Future<void> cacheBitcoinPrice(BitcoinPriceModel bitcoinPriceToCache);
}

const CACHED_BITCOIN_LASTPRICE = 'CACHED_BITCOIN_LASTPRICE';

class BitcoinPriceLocalDataSourceImpl implements BitcoinPriceLocalDataSource {
  final SharedPreferences sharedPreferences;

  BitcoinPriceLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheBitcoinPrice(BitcoinPriceModel bitcoinPriceToCache) {
    final jsonString = json.encode(bitcoinPriceToCache.toJson());
    return sharedPreferences.setString(
      CACHED_BITCOIN_LASTPRICE,
      jsonString,
    );
  }

  @override
  Future<BitcoinPriceModel> getLastBitcoinPrice() {
    final jsonString = sharedPreferences.getString(CACHED_BITCOIN_LASTPRICE);
    if (jsonString != null) {
      return Future.value(BitcoinPriceModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
