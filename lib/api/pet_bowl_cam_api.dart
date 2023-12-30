import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';
import 'package:pet_bowl_cam_app/model/servo.dart';
import 'package:pet_bowl_cam_app/model/time_server.dart';
import 'package:pet_bowl_cam_app/model/time_zone.dart';
import 'package:pet_bowl_cam_app/model/wifi.dart';

class PetBowlCamAPI {
  final String baseURL;

  PetBowlCamAPI({this.baseURL = "192.168.4.1"});

  Future<List<FeedingSchedule>> getFeedingSchedules() async {
    http.Response res = await http.get(Uri.http(baseURL, "/feeding_schedule"));

    if (res.statusCode != 200) {
      throw "Unable to retrieve feeding schedules";
    }

    List<dynamic> body = jsonDecode(res.body);

    return body.map((item) => FeedingSchedule.fromJson(item)).toList();
  }

  Future<bool> createFeedingSchedule(FeedingSchedule data) async {
    http.Response res = await http.post(Uri.http(baseURL, "/feeding_schedule"),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    return res.statusCode == 204;
  }

  Future<bool> updateFeedingSchedule(int id, FeedingSchedule data) async {
    Map<String, dynamic> body = {"id": id};
    body.addAll(data.toJson());

    http.Response res = await http.post(Uri.http(baseURL, "/feeding_schedule"),
        headers: {'Content-Type': 'application/json'}, body: json.encode(body));

    return res.statusCode == 204;
  }

  Future<bool> deleteFeedingSchedule(int index) async {
    http.Response res = await http.delete(
        Uri.http(baseURL, "/feeding_schedule", {"id": index.toString()}));

    return res.statusCode == 204;
  }

  Future<WiFi> getConnectedWiFi() async {
    http.Response res = await http.get(Uri.http(baseURL, "/wifi"));

    if (res.statusCode != 200) {
      throw "Unable to retrieve wifi data";
    }

    Map<String, dynamic> body = jsonDecode(res.body);

    return WiFi.fromJson(body);
  }

  Future<bool> updateWiFi(String ssid, String password) async {
    http.Response res = await http.post(Uri.http(baseURL, "/wifi"), headers: {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    }, body: <String, dynamic>{
      'ssid': ssid,
      'password': password
    });

    return res.statusCode == 204;
  }

  Future<Timezone> getTimeZone() async {
    http.Response res = await http.get(Uri.http(baseURL, "/tz"));

    if (res.statusCode != 200) {
      throw "Unable to retrieve timezone data";
    }

    Map<String, dynamic> body = jsonDecode(res.body);

    return Timezone.fromJson(body);
  }

  Future<bool> updateTimeZone(String tz) async {
    http.Response res =
        await http.post(Uri.http(baseURL, "/tz"), body: {'tz': tz});

    return res.statusCode == 204;
  }

  Future<Servo> getServoConfig() async {
    http.Response res = await http.get(Uri.http(baseURL, "/servo"));

    if (res.statusCode != 200) {
      throw "Unabled to retrieve timezone data";
    }

    Map<String, dynamic> body = jsonDecode(res.body);

    return Servo.fromJson(body);
  }

  Future<TimeServer> getTimeServers() async {
    http.Response res = await http.get(Uri.http(baseURL, "/time-server"));

    if (res.statusCode != 200) {
      throw "Unabled to retrieve time server data";
    }

    return TimeServer.fromJson(jsonDecode(res.body));
  }
}
