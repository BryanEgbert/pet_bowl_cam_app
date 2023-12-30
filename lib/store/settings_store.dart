import 'package:mobx/mobx.dart';
import 'package:pet_bowl_cam_app/api/pet_bowl_cam_api.dart';
import 'package:pet_bowl_cam_app/model/servo.dart';
import 'package:pet_bowl_cam_app/model/time_server.dart';
import 'package:pet_bowl_cam_app/model/time_zone.dart';
import 'package:pet_bowl_cam_app/model/wifi.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  final PetBowlCamAPI _pbcApi = PetBowlCamAPI();

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

  @action
  Future<WiFi> getConnectedWiFi() =>
      wifiFuture = ObservableFuture(_pbcApi.getConnectedWiFi());

  @action
  Future<Timezone> getTimeZone() =>
      timezoneFuture = ObservableFuture(_pbcApi.getTimeZone());

  @action
  Future<Servo> getServoConfig() =>
      servoFuture = ObservableFuture(_pbcApi.getServoConfig());

  @action
  Future<TimeServer> getTimeServer() =>
      timeServerFuture = ObservableFuture(_pbcApi.getTimeServers());

  @action
  Future<void> updateTimeZone(String tz) async {
    bool success = await _pbcApi.updateTimeZone(tz);

    timezoneFuture = ObservableFuture.value(Timezone(tz: tz));
  }

  @computed
  bool get isPending =>
      wifiFuture.status == FutureStatus.pending &&
      timezoneFuture.status == FutureStatus.pending &&
      servoFuture.status == FutureStatus.pending &&
      timeServerFuture.status == FutureStatus.pending;

  @computed
  bool get isRejected =>
      wifiFuture.status == FutureStatus.rejected &&
      timezoneFuture.status == FutureStatus.rejected &&
      servoFuture.status == FutureStatus.rejected &&
      timeServerFuture.status == FutureStatus.rejected;

  @computed
  bool get isFulfilled =>
      wifiFuture.status == FutureStatus.fulfilled &&
      timezoneFuture.status == FutureStatus.fulfilled &&
      servoFuture.status == FutureStatus.fulfilled &&
      timeServerFuture.status == FutureStatus.fulfilled;

  void initStore() {
    getConnectedWiFi();
    getTimeZone();
    getServoConfig();
    getTimeServer();
  }
}
