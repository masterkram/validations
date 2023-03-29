part of annotations.comparison;

/// Checks whether the annotated value is higher than or equal to the specified
/// minimum.
@immutable
@Constraint(validatedBy: GreaterThanOrEqualValidator)
@Target({ElementType.FIELD})
class GreaterThanOrEqual extends ValidatorAnnotation {
  final num value;
  const GreaterThanOrEqual({
    required this.value,
    String? message,
    List<String>? groups,
  }) : super(message, groups);
}
