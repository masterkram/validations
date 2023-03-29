import 'package:analyzer/dart/element/element.dart';
import 'package:validations/annotation.dart';

import 'get_annotation.dart';
import 'has_annotation.dart';

/// Checks whether the annotation is a validator annotation.
///
/// Tests this by whether the [Type] of this annotation has
/// a [@Constraint] and [@Target] annotation.
///
/// Note: If these are not specified the annotation will be silently ignored.
///
bool isValidatorAnnotation(ElementAnnotation annotation, [ElementType type]) {
  annotation.computeConstantValue();

  final constantValue = annotation.computeConstantValue();

  if (constantValue == null) return false;

  final element = constantValue.type.element as Element;

  final result =
      hasAnnotation(element, 'Constraint') && hasAnnotation(element, 'Target');

  if (result && type != null) {
    final target = getAnnotation(element, 'Target')..computeConstantValue();
    final targetsSet =
        target.computeConstantValue().getField('targets').toSetValue();

    final enumType = type.toString().split('.')[1];

    final hasType =
        targetsSet.any((value) => value?.getField(enumType) != null);

    if (!hasType) {
      throw Exception(
        'Validator Annotation ${element.name} cannot be used on $type',
      );
    }
  }

  return result;
}
