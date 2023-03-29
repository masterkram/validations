import 'package:analyzer/dart/element/element.dart';

ElementAnnotation getAnnotation(Element field, String name) {
  final result = field?.metadata?.firstWhere(
    (annotation) {
      annotation.computeConstantValue();

      return annotation.element.name == name ||
          annotation
                  .computeConstantValue()
                  ?.type
                  ?.getDisplayString(withNullability: true) ==
              name;
    },
    orElse: () => null,
  );

  return result;
}
