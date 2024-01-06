class FeedingSchedule {
  final int hour;
  final int minutes;
  final int seconds;

  const FeedingSchedule(
      {required this.hour, required this.minutes, required this.seconds});

  factory FeedingSchedule.fromJson(Map<String, dynamic> json) {
    return FeedingSchedule(
      hour: json['hour'] as int,
      minutes: json['minutes'] as int,
      seconds: json['seconds'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'hour': hour,
        'minutes': minutes,
        'seconds': seconds,
      };

  @override
  String toString() => "$hour:$minutes";
}
