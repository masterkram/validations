part of validators.comparison;

class EqualToValidator extends ConstraintValidator {
  final dynamic value;

  EqualToValidator({
    @required this.value,
  })  : assert(value != null),
        super([value]);

  @override
  bool isValid(dynamic value, [ValueContext context]) {
    return value == this.value;
  }

  @override
  Function message = (num value, Object validatedValue) =>
      '$validatedValue should be equal to $value';
}
