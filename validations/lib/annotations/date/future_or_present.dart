part of annotations.date;

/// Checks whether the annotated date is in the present or in the future
@immutable
@Constraint(validatedBy: FutureOrPresentValidator)
@Target({ElementType.FIELD})
class FutureOrPresent extends ValidatorAnnotation {
  final Object? timeUnit;
  const FutureOrPresent({
    this.timeUnit,
    String? message,
    List<String>? groups,
  }) : super(message, groups);
}
