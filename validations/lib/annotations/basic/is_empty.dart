part of annotations.basic;

/// Checks whether the annotated element is empty or null
@immutable
@Constraint(validatedBy: IsEmptyValidator)
@Target({ElementType.FIELD})
class IsEmpty extends ValidatorAnnotation {
  const IsEmpty({
    String? message,
    List<String>? groups,
  }) : super(message, groups);
}
