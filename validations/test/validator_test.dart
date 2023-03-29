import 'package:decimal/decimal.dart';
import 'package:test/test.dart';
import 'package:validations/validator.dart';

import 'models/car.dart';

void printViolations(Set<ConstraintViolation> violations) {
  for (var index = 0; index < violations.length; index++) {
    final violation = violations.elementAt(index);
    print(
      '$index(${violation.propertyPath}): ${violation.message}',
    );
  }
}

void main() {
  group('TestCarValidator', () {
    late TestCarValidator validator;
    setUp(() {
      validator = TestCarValidator();
    });

    group('validate()', () {
      test('Validates correctly configured car.', () {
        final car = Car()
          ..driver = Driver(name: 'TestDriver')
          ..price = Decimal.parse('99.99')
          ..isRegistered = true
          ..licensePlate = 'DY28-38'
          ..manufacturer = 'VEB Sachsenring'
          ..frontWheelCoverLeft = 'Black'
          ..frontWheelCoverRight = 'Black'
          ..rearWheelCoverLeft = 'Red'
          ..rearWheelCoverRight = 'Red'
          ..seatCount = 2
          ..topSpeed = 100;

        expect(validator.validate(car), isEmpty);
      });

      test('Collects all violations.', () {
        final validator = TestCarValidator();

        final car = Car()
          ..driver = Driver() // without name
          ..price = Decimal.parse('100.99')
          ..isRegistered = false
          ..licensePlate = 'D'
          ..manufacturer = null
          ..seatCount = 3
          ..topSpeed = 500
          ..frontWheelCoverLeft = 'Red'
          ..frontWheelCoverRight = 'Green'
          ..rearWheelCoverLeft = 'Blue'
          ..rearWheelCoverRight = 'Purple';

        final violations = validator.validate(car);

        // direct cleanup
        expect(validator.validationContext.constraintViolations, isEmpty);

        expect(violations.length, 12);

        expect(
          violations.elementAt(0).message,
          equals('Value cannot be null'),
        );

        expect(
          violations.elementAt(0).propertyPath,
          equals('Car.manufacturer'),
        );

        expect(
          violations.elementAt(1).message,
          equals('Value cannot be null'),
        );

        expect(
          violations.elementAt(1).propertyPath,
          equals('Car.driver.name'),
        );

        expect(
          violations.elementAt(2).message,
          equals('There should be a valid driver!'),
        );

        expect(
          violations.elementAt(2).propertyPath,
          equals('Car.driver'),
        );

        expect(
          violations.elementAt(3).message,
          equals(
              'The license plate D must be between 2 and 14 characters long'),
        );

        expect(
          violations.elementAt(3).propertyPath,
          equals('Car.licensePlate'),
        );

        expect(
          violations.elementAt(4).message,
          equals('Car cannot have more than 2 seats'),
        );

        expect(
          violations.elementAt(4).propertyPath,
          equals('Car.seatCount'),
        );

        expect(
          violations.elementAt(5).message,
          equals('The top speed 500 is higher than 350'),
        );

        expect(
          violations.elementAt(5).propertyPath,
          equals('Car.topSpeed'),
        );

        expect(
          violations.elementAt(6).message,
          equals('Price must not be higher than 100.00'),
        );

        expect(
          violations.elementAt(6).propertyPath,
          equals('Car.price'),
        );

        expect(
          violations.elementAt(7).message,
          equals('Car must be registered!'),
        );

        expect(
          violations.elementAt(7).propertyPath,
          equals('Car.isRegistered'),
        );

        expect(
          violations.elementAt(8).message,
          equals(
            'Left and Right front wheel covers should match!',
          ),
        );

        expect(
          violations.elementAt(8).propertyPath,
          equals('Car.frontWheelCoverLeft'),
        );

        expect(
          violations.elementAt(9).message,
          equals(
            'Fields frontWheelCoverLeft and frontWheelCoverRight should match',
          ),
        );

        expect(
          violations.elementAt(9).propertyPath,
          equals('Car.frontWheelCoverRight'),
        );

        expect(
          violations.elementAt(10).message,
          equals(
            'Fields rearWheelCoverLeft and rearWheelCoverRight should match',
          ),
        );

        expect(
          violations.elementAt(10).propertyPath,
          equals('Car.rearWheelCoverLeft'),
        );

        expect(
          violations.elementAt(11).message,
          equals(
            'Left and Right rear wheel covers should match!',
          ),
        );

        expect(
          violations.elementAt(11).propertyPath,
          equals('Car.rearWheelCoverRight'),
        );
      });
    });

    group('validateProperty()', () {
      test('Validates single properties of correctly configured car.', () {
        final car = Car()
          ..driver = Driver(name: 'TestDriver')
          ..price = Decimal.parse('99.99')
          ..isRegistered = true
          ..licensePlate = 'DY28-38'
          ..manufacturer = 'VEB Sachsenring'
          ..seatCount = 2
          ..topSpeed = 100;

        expect(validator.validateProperty(car, 'driver'), isEmpty);
        expect(validator.validateProperty(car, 'price'), isEmpty);
        expect(validator.validateProperty(car, 'isRegistered'), isEmpty);
        expect(validator.validateProperty(car, 'licensePlate'), isEmpty);
        expect(validator.validateProperty(car, 'manufacturer'), isEmpty);
        expect(validator.validateProperty(car, 'seatCount'), isEmpty);
        expect(validator.validateProperty(car, 'topSpeed'), isEmpty);

        expect(validator.validationContext.constraintViolations, isEmpty);
      });

      test('Collects violations per property.', () {
        final validator = TestCarValidator();

        final car = Car()
          ..driver = Driver()
          ..price = Decimal.parse('100.99')
          ..isRegistered = false
          ..licensePlate = 'D'
          ..manufacturer = null
          ..seatCount = 3
          ..topSpeed = 500
          ..frontWheelCoverLeft = 'Red'
          ..frontWheelCoverRight = 'Blue'
          ..rearWheelCoverLeft = 'Pink'
          ..rearWheelCoverRight = 'Purple';

        expect(
          validator.validateProperty(car, 'manufacturer').first.message,
          equals('Value cannot be null'),
        );

        expect(
          validator.validateProperty(car, 'licensePlate').first.message,
          equals(
              'The license plate D must be between 2 and 14 characters long'),
        );

        expect(
          validator.validateProperty(car, 'seatCount').first.message,
          equals('Car cannot have more than 2 seats'),
        );

        expect(
          validator.validateProperty(car, 'topSpeed').first.message,
          equals('The top speed 500 is higher than 350'),
        );

        expect(
          validator.validateProperty(car, 'price').first.message,
          equals('Price must not be higher than 100.00'),
        );

        expect(
          validator.validateProperty(car, 'isRegistered').first.message,
          equals('Car must be registered!'),
        );

        expect(
          validator.validateProperty(car, 'frontWheelCoverLeft').first.message,
          equals(
            'Left and Right front wheel covers should match!',
          ),
        );

        expect(
          validator.validateProperty(car, 'frontWheelCoverRight').first.message,
          equals(
            'Fields frontWheelCoverLeft and frontWheelCoverRight should match',
          ),
        );

        expect(
          validator.validateProperty(car, 'rearWheelCoverLeft').first.message,
          equals(
            'Fields rearWheelCoverLeft and rearWheelCoverRight should match',
          ),
        );

        expect(
          validator.validateProperty(car, 'rearWheelCoverRight').first.message,
          equals(
            'Left and Right rear wheel covers should match!',
          ),
        );

        expect(validator.validationContext.constraintViolations, isEmpty);
      });
    });

    test('validateValue()', () {
      expect(
        validator.validateValue('manufacturer', 'Mercedes'),
        isEmpty,
      );
      expect(
        validator
            .validateValue('licensePlate', 'abcdefghijklmno')
            .first
            .message,
        equals(
          'The license plate abcdefghijklmno must be between 2 and 14 characters long',
        ),
      );
      expect(
        validator.validateValue('seatCount', 9).first.message,
        equals('Car cannot have more than 2 seats'),
      );
      expect(
        validator.validateValue('topSpeed', 1000).first.message,
        equals('The top speed 1000 is higher than 350'),
      );
      expect(
        validator.validateValue('price', '150.00').first.message,
        equals('Price must not be higher than 100.00'),
      );
      expect(
        validator.validateValue('isRegistered', false).first.message,
        equals('Car must be registered!'),
      );

      expect(validator.validationContext.constraintViolations, isEmpty);
    });
  });
}
