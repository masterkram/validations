library validators.mixed;

import 'package:decimal/decimal.dart';

import '../validator.dart';

part 'mixed/digits.dart';
part 'mixed/size.dart';

final mixedValidators = [
  DigitsValidator,
  SizeValidator,
];
