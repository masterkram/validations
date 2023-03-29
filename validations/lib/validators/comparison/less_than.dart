part of validators.comparison;

/// Checks if the value being tested is less than [value].
///
/// Supported types: All values implementing the `<` operator.
class LessThanValidator extends ConstraintValidator {
  final dynamic value;

  LessThanValidator({
    required this.value,
  })  : assert(value != null),
        super([value]);

  @override
  bool? isValid(dynamic value, ValueContext context) {
    try {
      return value < this.value as bool?;
    } catch (_) {
      return false;
    }
  }

  @override
  Function message = (dynamic value, Object validatedValue) =>
      '$validatedValue should be less than $value';
}
