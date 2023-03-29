part of annotations.comparison;

/// Checks whether the annotated value is less than or equal to the specified
/// maximum.
@immutable
@Constraint(validatedBy: MaxValidator)
@Target({ElementType.FIELD})
class Max extends LessThanOrEqual {
  const Max({
    required num value,
    String? message,
    List<String>? groups,
  }) : super(
          value: value,
          message: message,
          groups: groups,
        );
}
