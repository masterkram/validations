part of validators.string;

/// Checks whether the value is a valid email address.
///
/// Supported types: [String]
class EmailValidator extends ConstraintValidator {
  @override
  bool isValid(dynamic value, ValueContext context) {
    return value is String && isEmail(value);
  }

  @override
  Function message = (Object validatedValue) => 'Invalid email address';
}
