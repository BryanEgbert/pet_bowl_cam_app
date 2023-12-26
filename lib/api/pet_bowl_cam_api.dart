import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';

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

  Future<bool> deleteFeedingSchedule(int index) async {
    http.Response res = await http.delete(
        Uri.http(baseURL, "/feeding_schedule", {"id": index.toString()}));

    return res.statusCode == 204;
  }

  Future<bool> createFeedingSchedule(FeedingSchedule data) async {
    http.Response res = await http.post(Uri.http(baseURL, "/feeding_schedule"),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    return res.statusCode == 204;
  }
}
