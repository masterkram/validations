import '../constraint_validator.dart';
import '../validator_context.dart';

class AssertFalseValidator extends ConstraintValidator {
  @override
  bool isValid(dynamic value, ValidatorContext context) {
    return value == false;
  }

  @override
  Function message = () => 'Value is not false';
}
