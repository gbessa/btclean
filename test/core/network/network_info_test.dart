import 'package:btclean/core/network/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  test('should forward the call to DataConnectionChecker', () async {
    // arrange
    final tHasConnectionFuture = Future.value(true);
    when(mockDataConnectionChecker.hasConnection)
        .thenAnswer((_) => tHasConnectionFuture);
    // act
    final result = networkInfoImpl.isConnected;
    // assert
    verify(mockDataConnectionChecker.hasConnection);
    expect(result, tHasConnectionFuture);
  });
}
