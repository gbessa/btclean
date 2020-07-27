import 'package:btclean/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group(
    'stringToUnsignedInt',
    () {
      test(
        'should return a integer when the string represents a unsigned integer',
        () async {
          // act
          final str = '123';
          final result = inputConverter.stringToUnsignedInteger(str);
          // assert
          expect(result, equals(Right(123)));
        },
      );

      test(
        'should return InvalidInputFailure when the string does not represents a integer',
        () async {
          // act
          final str = 'abc';
          final result = inputConverter.stringToUnsignedInteger(str);
          // assert
          expect(result, Left(InvalidInputFailure()));
        },
      );

      test(
        'should return InvalidInputFailure when the string is a negative integer',
        () async {
          // act
          final str = '-10';
          final result = inputConverter.stringToUnsignedInteger(str);
          // assert
          expect(result, Left(InvalidInputFailure()));
        },
      );
    },
  );
}
