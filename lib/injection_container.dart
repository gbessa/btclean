import 'package:btclean/core/network/network_info.dart';
import 'package:btclean/core/util/input_converter.dart';
import 'package:btclean/features/bitcoin_price/data/datasources/bitcoin_price_local_data_source.dart';
import 'package:btclean/features/bitcoin_price/data/datasources/bitcoin_price_remote_data_source.dart';
import 'package:btclean/features/bitcoin_price/data/repositories/bitcoin_price_repository_impl.dart';
import 'package:btclean/features/bitcoin_price/domain/repositories/bitcoin_price_repository.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/bitcoin_price/domain/usecases/get_current_price.dart';
import 'features/bitcoin_price/presentation/bloc/bitcoin_price_bloc.dart';

import 'package:http/http.dart' as http;

// sl -> Service Locator. It's the GET_IT classes searcher for providing Loose Coupling. ex: sl()
final sl = GetIt.instance;

Future<void> init() async {
  // 1. Features - Bitcoin Price
  // Bloc
  sl.registerFactory(() => BitcoinPriceBloc(
        getCurrentPrice: sl(),
        inputConverter: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetCurrentPrice(sl()));

  // Repository
  sl.registerLazySingleton<BitCoinPriceRepository>(() =>
      BitcoinPriceRepositoryImpl(
          localDataSource: sl(), networkInfo: sl(), remoteDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<BitcoinPriceRemoteDataSource>(
      () => BitcoinPriceRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<BitcoinPriceLocalDataSource>(
      () => BitcoinPriceLocalDataSourceImpl(sharedPreferences: sl()));

  // 2. Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  // 3. External
  final sharedPreferences = await SharedPreferences
      .getInstance(); // Different injection because it returns a Future
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() => DataConnectionChecker());
}
