class Servo {
  final bool openOnTimeout;
  final int servoOpenMs;

  Servo({this.openOnTimeout = true, this.servoOpenMs = 0});

  factory Servo.fromJson(Map<String, dynamic> json) {
    return Servo(
      openOnTimeout: json['openOnTimeout'],
      servoOpenMs: json['servoOpenMs'],
    );
  }
}
