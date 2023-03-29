part of annotations.comparison;

/// Checks whether the annotated value is not identical to another value.
@immutable
@Constraint(validatedBy: NotIdenticalToValidator)
@Target({ElementType.FIELD})
class NotIdenticalTo extends ValidatorAnnotation {
  final Object value;

  /// TODO: make propertyPath a proper object.
  final List<String>? propertyPath;
  const NotIdenticalTo({
    required this.value,
    this.propertyPath,
    String? message,
    List<String>? groups,
  }) : super(message, groups);
}
