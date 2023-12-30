class Timezone {
  final String tz;

  Timezone({this.tz = ""});

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(tz: json['tz']);
  }
}
