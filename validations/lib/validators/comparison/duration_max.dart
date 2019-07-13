part of validators.comparison;

class DurationMaxValidator extends ConstraintValidator {
  Duration duration;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final int milliseconds;
  final int microseconds;
  final bool inclusive;

  DurationMaxValidator({
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.milliseconds = 0,
    this.microseconds = 0,
    this.inclusive,
  }) : super([]);

  @override
  void initialize() {
    duration = Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
      microseconds: microseconds,
    );

    argumentValues.add(duration);
  }

  @override
  bool isValid(dynamic value, [ValueContext context]) {
    if (value is! Duration) return false;

    if (inclusive) {
      return value as Duration <= duration;
    }

    return value as Duration < duration;
  }

  @override
  Function message = (Duration duration, Object validatedValue) =>
      '$validatedValue should not last longer than ${duration.toString()}.';
}
