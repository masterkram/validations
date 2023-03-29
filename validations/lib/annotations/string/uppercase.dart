part of annotations.string;

/// Checks that the annotated string is uppercase.
@immutable
@Constraint(validatedBy: UppercaseValidator)
@Target({ElementType.FIELD})
class Uppercase extends ValidatorAnnotation {
  const Uppercase({
    String? message,
    List<String>? groups,
  }) : super(message, groups);
}
