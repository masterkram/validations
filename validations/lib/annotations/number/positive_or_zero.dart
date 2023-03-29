part of annotations.number;

/// Checks if the element is positive or zero.
@immutable
@Constraint(validatedBy: PositiveOrZeroValidator)
@Target({ElementType.FIELD})
class PositiveOrZero extends ValidatorAnnotation {
  const PositiveOrZero({
    String? message,
    List<String>? groups,
  }) : super(message, groups);
}
