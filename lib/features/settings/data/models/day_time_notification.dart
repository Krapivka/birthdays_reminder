import 'dart:convert';

class DayTimeNotification {
  DayTimeNotification({
    required this.day,
    required this.hour,
    required this.minute,
  });

  int day;
  int hour;
  int minute;

  DayTimeNotification copyWith({
    int? day,
    int? hour,
    int? minute,
  }) {
    return DayTimeNotification(
      day: day ?? this.day,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'hour': hour,
      'minute': minute,
    };
  }

  factory DayTimeNotification.fromMap(Map<String, dynamic> map) {
    return DayTimeNotification(
      day: map['day']?.toInt() ?? 0,
      hour: map['hour']?.toInt() ?? 0,
      minute: map['minute']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DayTimeNotification.fromJson(String source) =>
      DayTimeNotification.fromMap(json.decode(source));

  @override
  String toString() =>
      'DayTimeNotification(day: $day, hour: $hour, minute: $minute)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DayTimeNotification &&
        other.day == day &&
        other.hour == hour &&
        other.minute == minute;
  }

  @override
  int get hashCode => day.hashCode ^ hour.hashCode ^ minute.hashCode;
}
