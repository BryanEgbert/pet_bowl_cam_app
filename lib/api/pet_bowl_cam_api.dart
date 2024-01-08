import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';
import 'package:pet_bowl_cam_app/model/hardware.dart';
import 'package:pet_bowl_cam_app/model/servo.dart';
import 'package:pet_bowl_cam_app/model/time_server.dart';
import 'package:pet_bowl_cam_app/model/time_zone.dart';
import 'package:pet_bowl_cam_app/model/wifi.dart';

class PetBowlCamAPI {
  String baseURL;

  PetBowlCamAPI({this.baseURL = "192.168.4.1"});

  void setBaseURL(String url) {
    baseURL = url;
  }

  Future<List<FeedingSchedule>> getFeedingSchedules() async {
    http.Response res = await http
        .get(Uri.http(baseURL, "/feeding_schedule"))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    List<dynamic> body = jsonDecode(res.body);

    return body.map((item) => FeedingSchedule.fromJson(item)).toList();
  }

  Future<bool> createFeedingSchedule(FeedingSchedule data) async {
    http.Response res = await http
        .post(Uri.http(baseURL, "/feeding_schedule"),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 204) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    return true;
  }

  Future<bool> updateFeedingSchedule(int id, FeedingSchedule data) async {
    Map<String, dynamic> body = {"id": id};
    body.addAll(data.toJson());

    http.Response res = await http
        .post(Uri.http(baseURL, "/feeding_schedule"),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(body))
        .timeout(const Duration(seconds: 10));

    return res.statusCode == 204;
  }

  Future<bool> deleteFeedingSchedule(int index) async {
    http.Response res = await http
        .delete(
            Uri.http(baseURL, "/feeding_schedule", {"id": index.toString()}))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 204) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    return true;
  }

  Future<WiFi> getConnectedWiFi() async {
    http.Response res = await http
        .get(Uri.http(baseURL, "/wifi"))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw HttpException(jsonDecode(res.body)['message']);
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
    }).timeout(const Duration(seconds: 10));

    if (res.statusCode != 204) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    return true;
  }

  Future<Timezone> getTimeZone() async {
    http.Response res = await http
        .get(Uri.http(baseURL, "/tz"))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    Map<String, dynamic> body = jsonDecode(res.body);

    return Timezone.fromJson(body);
  }

  Future<bool> updateTimeZone(String tz) async {
    http.Response res = await http.post(Uri.http(baseURL, "/tz"),
        body: {'tz': tz}).timeout(const Duration(seconds: 10));

    if (res.statusCode != 204) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    return true;
  }

  Future<Servo> getServoConfig() async {
    http.Response res = await http
        .get(Uri.http(baseURL, "/servo"))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    Map<String, dynamic> body = jsonDecode(res.body);

    return Servo.fromJson(body);
  }

  Future<bool> updateServoConfig(
      bool shouldOpenIfTimeout, int servoOpenMs) async {
    http.Response res = await http.post(Uri.http(baseURL, "/servo"), headers: {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    }, body: {
      'shouldOpenIfTimeout': shouldOpenIfTimeout.toString(),
      'servoOpenMs': servoOpenMs.toString(),
    }).timeout(const Duration(seconds: 10));

    if (res.statusCode != 204) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    return true;
  }

  Future<TimeServer> getTimeServers() async {
    http.Response res = await http
        .get(Uri.http(baseURL, "/time-server"))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    return TimeServer.fromJson(jsonDecode(res.body));
  }

  Future<bool> updateTimeServer(String url1, String url2, String url3) async {
    http.Response res =
        await http.post(Uri.http(baseURL, "/time-server"), headers: {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    }, body: {
      'timeServerUrl1': url1,
      'timeServerUrl2': url2,
      'timeServerUrl3': url3,
    }).timeout(const Duration(seconds: 10));

    if (res.statusCode != 204) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    return true;
  }

  Future<Hardware> getHardwareInfo() async {
    http.Response res = await http
        .get(Uri.http(baseURL, "/hardware"))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    return Hardware.fromJson(jsonDecode(res.body));
  }

  Future<bool> openServo() async {
    http.Response res = await http
        .post(Uri.http(baseURL, "/servo/open"))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 202) {
      throw HttpException(jsonDecode(res.body)['message']);
    }

    return true;
  }

  Future<bool> resetBoard() async {
    http.Response res = await http
        .post(Uri.http(baseURL, "/reset"))
        .timeout(const Duration(seconds: 10));

    return res.statusCode == 204;
  }
}
