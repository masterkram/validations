part of annotations.comparison;

/// Checks whether the annotated value is [identical] to another value.
@immutable
@Constraint(validatedBy: IdenticalToValidator)
@Target({ElementType.FIELD})
class IdenticalTo extends ValidatorAnnotation {
  final Object value;

  const IdenticalTo({
    required this.value,
    String? message,
    List<String>? groups,
  }) : super(message, groups);
}
