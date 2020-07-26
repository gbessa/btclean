import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl({@required this.connectionChecker});

  @override
  Future<bool> get isConnected {
    return connectionChecker.hasConnection;
  }
}
