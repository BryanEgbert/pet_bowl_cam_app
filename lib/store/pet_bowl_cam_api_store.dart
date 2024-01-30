import 'package:mobx/mobx.dart';
import 'package:pet_bowl_cam_app/api/pet_bowl_cam_api.dart';
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';
import 'package:pet_bowl_cam_app/model/hardware.dart';
import 'package:pet_bowl_cam_app/model/mqtt_server.dart';
import 'package:pet_bowl_cam_app/model/server_url.dart';
import 'package:pet_bowl_cam_app/model/servo.dart';
import 'package:pet_bowl_cam_app/model/time_server.dart';
import 'package:pet_bowl_cam_app/model/time_zone.dart';
import 'package:pet_bowl_cam_app/model/wifi.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pet_bowl_cam_api_store.g.dart';

class PetBowlCamAPIStore = _PetBowlCamAPIStore with _$PetBowlCamAPIStore;

abstract class _PetBowlCamAPIStore with Store {
  @observable
  ObservableFuture<List<FeedingSchedule>> feedingSchedulesFuture =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<WiFi> wifiFuture = ObservableFuture.value(WiFi());

  @observable
  ObservableFuture<Timezone> timezoneFuture =
      ObservableFuture.value(Timezone());

  @observable
  ObservableFuture<Servo> servoFuture = ObservableFuture.value(Servo());

  @observable
  ObservableFuture<TimeServer> timeServerFuture =
      ObservableFuture.value(TimeServer());

  @observable
  ObservableFuture<Hardware> hardwareInfoFuture =
      ObservableFuture.value(Hardware());

  @observable
  ObservableFuture<Server> serverUrlFuture = ObservableFuture.value(
      Server(mqttServer: MqttServerProperty(topic: "test/test")));

  @action
  Future<List<FeedingSchedule>> getFeedingSchedules() {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    feedingSchedulesFuture = ObservableFuture(pbcApi.getFeedingSchedules());

    return feedingSchedulesFuture;
  }

  @action
  Future<void> createFeedingSchedule(FeedingSchedule data) async {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    await pbcApi.createFeedingSchedule(data);

    feedingSchedulesFuture = ObservableFuture(pbcApi.getFeedingSchedules());
  }

  @action
  Future<void> updateFeedingSchedule(int id, FeedingSchedule data) async {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    await pbcApi.updateFeedingSchedule(id, data);

    feedingSchedulesFuture = ObservableFuture(pbcApi.getFeedingSchedules());
  }

  @action
  Future<void> deleteFeedingSchedules(int index) async {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    await pbcApi.deleteFeedingSchedule(index);

    feedingSchedulesFuture = ObservableFuture(pbcApi.getFeedingSchedules());
  }

  @action
  Future<WiFi> getConnectedWiFi() {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    wifiFuture = ObservableFuture(pbcApi.getConnectedWiFi());

    return wifiFuture;
  }

  @action
  Future<void> updateWiFi(String ssid, String password) async {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    bool success = await pbcApi.updateWiFi(ssid, password);

    wifiFuture = ObservableFuture(pbcApi.getConnectedWiFi());
  }

  @action
  Future<Timezone> getTimeZone() {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    timezoneFuture = ObservableFuture(pbcApi.getTimeZone());

    return timezoneFuture;
  }

  @action
  Future<Servo> getServoConfig() {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    servoFuture = ObservableFuture(pbcApi.getServoConfig());

    return servoFuture;
  }

  @action
  Future<void> updateServoConfig(bool openOnTimeout, int servoOpenMs) async {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    bool success = await pbcApi.updateServoConfig(openOnTimeout, servoOpenMs);

    servoFuture = ObservableFuture.value(
        Servo(openOnTimeout: openOnTimeout, servoOpenMs: servoOpenMs));
  }

  @action
  Future<TimeServer> getTimeServer() {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    timeServerFuture = ObservableFuture(pbcApi.getTimeServers());

    return timeServerFuture;
  }

  @action
  Future<void> updateTimeServer(String url1, String url2, String url3) async {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    bool success = await pbcApi.updateTimeServer(url1, url2, url3);

    timeServerFuture = ObservableFuture(pbcApi.getTimeServers());
  }

  @action
  Future<void> updateTimeZone(String tz) async {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    await pbcApi.updateTimeZone(tz);

    timezoneFuture = ObservableFuture.value(Timezone(tz: tz));
  }

  @action
  Future<Hardware> getHardwareInfo() {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    hardwareInfoFuture = ObservableFuture(pbcApi.getHardwareInfo());

    return hardwareInfoFuture;
  }

  @action
  Future<void> openServo() async {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    bool success = await pbcApi.openServo();
  }

  @action
  Future<void> resetBoard() async {
    final PetBowlCamAPI pbcApi = PetBowlCamAPI(
        baseURL: serverUrlFuture.value?.aiServer ?? "192.168.4.1");

    bool success = await pbcApi.resetBoard();
  }

  @action
  Future<Server> getServerUrl() async {
    final prefs = await SharedPreferences.getInstance();
    final mqttServerProp = MqttServerProperty(
        host: prefs.getString("mqttHost") ?? "127.0.0.1",
        port: prefs.getInt("mqttPort") ?? 1883,
        topic: prefs.getString("mqttTopic") ?? "topic/queue",
        username: prefs.getString("mqttUsername"),
        password: prefs.getString("mqttPassword"));

    serverUrlFuture = ObservableFuture.value(
      Server(
        aiServer: prefs.getString("aiServer") ?? "192.168.4.1",
        mqttServer: mqttServerProp,
      ),
    );

    return serverUrlFuture;
  }

  @action
  Future<void> updateServerUrl(Server data) async {
    final prefs = await SharedPreferences.getInstance();

    if (!await prefs.setString("aiServer", data.aiServer) ||
        !await prefs.setString("mqttHost", data.mqttServer.host) ||
        !await prefs.setInt("mqttPort", data.mqttServer.port) ||
        !await prefs.setString("mqttTopic", data.mqttServer.topic)) {
      throw Exception("Failed to store data");
    }

    if (data.mqttServer.username != null && data.mqttServer.password != null) {
      if (!await prefs.setString("mqttUsername", data.mqttServer.username!) ||
          !await prefs.setString("mqttPassword", data.mqttServer.password!)) {
        throw Exception("Failed to store data");
      }
    }

    serverUrlFuture = ObservableFuture.value(await getServerUrl());
  }

  @computed
  bool get settingsIsPending =>
      wifiFuture.status == FutureStatus.pending ||
      timezoneFuture.status == FutureStatus.pending ||
      servoFuture.status == FutureStatus.pending ||
      timeServerFuture.status == FutureStatus.pending ||
      hardwareInfoFuture.status == FutureStatus.pending;

  @computed
  bool get settingsIsRejected =>
      wifiFuture.status == FutureStatus.rejected &&
      timezoneFuture.status == FutureStatus.rejected &&
      servoFuture.status == FutureStatus.rejected &&
      timeServerFuture.status == FutureStatus.rejected &&
      hardwareInfoFuture.status == FutureStatus.rejected;

  @computed
  bool get settingsIsFulfilled =>
      serverUrlFuture.status == FutureStatus.fulfilled &&
      wifiFuture.status == FutureStatus.fulfilled &&
      timezoneFuture.status == FutureStatus.fulfilled &&
      servoFuture.status == FutureStatus.fulfilled &&
      timeServerFuture.status == FutureStatus.fulfilled &&
      hardwareInfoFuture.status == FutureStatus.fulfilled;

  void initStore() {
    // IMPORTANT: Must be first to initialize url for API calls
    getServerUrl();

    getConnectedWiFi();
    getFeedingSchedules();
    getTimeZone();
    getServoConfig();
    getHardwareInfo();
    getTimeServer();
  }
}
