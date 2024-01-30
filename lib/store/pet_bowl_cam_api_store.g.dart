// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_bowl_cam_api_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetBowlCamAPIStore on _PetBowlCamAPIStore, Store {
  Computed<bool>? _$settingsIsPendingComputed;

  @override
  bool get settingsIsPending => (_$settingsIsPendingComputed ??= Computed<bool>(
          () => super.settingsIsPending,
          name: '_PetBowlCamAPIStore.settingsIsPending'))
      .value;
  Computed<bool>? _$settingsIsRejectedComputed;

  @override
  bool get settingsIsRejected => (_$settingsIsRejectedComputed ??=
          Computed<bool>(() => super.settingsIsRejected,
              name: '_PetBowlCamAPIStore.settingsIsRejected'))
      .value;
  Computed<bool>? _$settingsIsFulfilledComputed;

  @override
  bool get settingsIsFulfilled => (_$settingsIsFulfilledComputed ??=
          Computed<bool>(() => super.settingsIsFulfilled,
              name: '_PetBowlCamAPIStore.settingsIsFulfilled'))
      .value;

  late final _$feedingSchedulesFutureAtom = Atom(
      name: '_PetBowlCamAPIStore.feedingSchedulesFuture', context: context);

  @override
  ObservableFuture<List<FeedingSchedule>> get feedingSchedulesFuture {
    _$feedingSchedulesFutureAtom.reportRead();
    return super.feedingSchedulesFuture;
  }

  @override
  set feedingSchedulesFuture(ObservableFuture<List<FeedingSchedule>> value) {
    _$feedingSchedulesFutureAtom
        .reportWrite(value, super.feedingSchedulesFuture, () {
      super.feedingSchedulesFuture = value;
    });
  }

  late final _$wifiFutureAtom =
      Atom(name: '_PetBowlCamAPIStore.wifiFuture', context: context);

  @override
  ObservableFuture<WiFi> get wifiFuture {
    _$wifiFutureAtom.reportRead();
    return super.wifiFuture;
  }

  @override
  set wifiFuture(ObservableFuture<WiFi> value) {
    _$wifiFutureAtom.reportWrite(value, super.wifiFuture, () {
      super.wifiFuture = value;
    });
  }

  late final _$timezoneFutureAtom =
      Atom(name: '_PetBowlCamAPIStore.timezoneFuture', context: context);

  @override
  ObservableFuture<Timezone> get timezoneFuture {
    _$timezoneFutureAtom.reportRead();
    return super.timezoneFuture;
  }

  @override
  set timezoneFuture(ObservableFuture<Timezone> value) {
    _$timezoneFutureAtom.reportWrite(value, super.timezoneFuture, () {
      super.timezoneFuture = value;
    });
  }

  late final _$servoFutureAtom =
      Atom(name: '_PetBowlCamAPIStore.servoFuture', context: context);

  @override
  ObservableFuture<Servo> get servoFuture {
    _$servoFutureAtom.reportRead();
    return super.servoFuture;
  }

  @override
  set servoFuture(ObservableFuture<Servo> value) {
    _$servoFutureAtom.reportWrite(value, super.servoFuture, () {
      super.servoFuture = value;
    });
  }

  late final _$timeServerFutureAtom =
      Atom(name: '_PetBowlCamAPIStore.timeServerFuture', context: context);

  @override
  ObservableFuture<TimeServer> get timeServerFuture {
    _$timeServerFutureAtom.reportRead();
    return super.timeServerFuture;
  }

  @override
  set timeServerFuture(ObservableFuture<TimeServer> value) {
    _$timeServerFutureAtom.reportWrite(value, super.timeServerFuture, () {
      super.timeServerFuture = value;
    });
  }

  late final _$hardwareInfoFutureAtom =
      Atom(name: '_PetBowlCamAPIStore.hardwareInfoFuture', context: context);

  @override
  ObservableFuture<Hardware> get hardwareInfoFuture {
    _$hardwareInfoFutureAtom.reportRead();
    return super.hardwareInfoFuture;
  }

  @override
  set hardwareInfoFuture(ObservableFuture<Hardware> value) {
    _$hardwareInfoFutureAtom.reportWrite(value, super.hardwareInfoFuture, () {
      super.hardwareInfoFuture = value;
    });
  }

  late final _$serverUrlFutureAtom =
      Atom(name: '_PetBowlCamAPIStore.serverUrlFuture', context: context);

  @override
  ObservableFuture<Server> get serverUrlFuture {
    _$serverUrlFutureAtom.reportRead();
    return super.serverUrlFuture;
  }

  @override
  set serverUrlFuture(ObservableFuture<Server> value) {
    _$serverUrlFutureAtom.reportWrite(value, super.serverUrlFuture, () {
      super.serverUrlFuture = value;
    });
  }

  late final _$createFeedingScheduleAsyncAction = AsyncAction(
      '_PetBowlCamAPIStore.createFeedingSchedule',
      context: context);

  @override
  Future<void> createFeedingSchedule(FeedingSchedule data) {
    return _$createFeedingScheduleAsyncAction
        .run(() => super.createFeedingSchedule(data));
  }

  late final _$updateFeedingScheduleAsyncAction = AsyncAction(
      '_PetBowlCamAPIStore.updateFeedingSchedule',
      context: context);

  @override
  Future<void> updateFeedingSchedule(int id, FeedingSchedule data) {
    return _$updateFeedingScheduleAsyncAction
        .run(() => super.updateFeedingSchedule(id, data));
  }

  late final _$deleteFeedingSchedulesAsyncAction = AsyncAction(
      '_PetBowlCamAPIStore.deleteFeedingSchedules',
      context: context);

  @override
  Future<void> deleteFeedingSchedules(int index) {
    return _$deleteFeedingSchedulesAsyncAction
        .run(() => super.deleteFeedingSchedules(index));
  }

  late final _$updateWiFiAsyncAction =
      AsyncAction('_PetBowlCamAPIStore.updateWiFi', context: context);

  @override
  Future<void> updateWiFi(String ssid, String password) {
    return _$updateWiFiAsyncAction.run(() => super.updateWiFi(ssid, password));
  }

  late final _$updateServoConfigAsyncAction =
      AsyncAction('_PetBowlCamAPIStore.updateServoConfig', context: context);

  @override
  Future<void> updateServoConfig(bool openOnTimeout, int servoOpenMs) {
    return _$updateServoConfigAsyncAction
        .run(() => super.updateServoConfig(openOnTimeout, servoOpenMs));
  }

  late final _$updateTimeServerAsyncAction =
      AsyncAction('_PetBowlCamAPIStore.updateTimeServer', context: context);

  @override
  Future<void> updateTimeServer(String url1, String url2, String url3) {
    return _$updateTimeServerAsyncAction
        .run(() => super.updateTimeServer(url1, url2, url3));
  }

  late final _$updateTimeZoneAsyncAction =
      AsyncAction('_PetBowlCamAPIStore.updateTimeZone', context: context);

  @override
  Future<void> updateTimeZone(String tz) {
    return _$updateTimeZoneAsyncAction.run(() => super.updateTimeZone(tz));
  }

  late final _$openServoAsyncAction =
      AsyncAction('_PetBowlCamAPIStore.openServo', context: context);

  @override
  Future<void> openServo() {
    return _$openServoAsyncAction.run(() => super.openServo());
  }

  late final _$resetBoardAsyncAction =
      AsyncAction('_PetBowlCamAPIStore.resetBoard', context: context);

  @override
  Future<void> resetBoard() {
    return _$resetBoardAsyncAction.run(() => super.resetBoard());
  }

  late final _$getServerUrlAsyncAction =
      AsyncAction('_PetBowlCamAPIStore.getServerUrl', context: context);

  @override
  Future<Server> getServerUrl() {
    return _$getServerUrlAsyncAction.run(() => super.getServerUrl());
  }

  late final _$updateServerUrlAsyncAction =
      AsyncAction('_PetBowlCamAPIStore.updateServerUrl', context: context);

  @override
  Future<void> updateServerUrl(Server data) {
    return _$updateServerUrlAsyncAction.run(() => super.updateServerUrl(data));
  }

  late final _$_PetBowlCamAPIStoreActionController =
      ActionController(name: '_PetBowlCamAPIStore', context: context);

  @override
  Future<List<FeedingSchedule>> getFeedingSchedules() {
    final _$actionInfo = _$_PetBowlCamAPIStoreActionController.startAction(
        name: '_PetBowlCamAPIStore.getFeedingSchedules');
    try {
      return super.getFeedingSchedules();
    } finally {
      _$_PetBowlCamAPIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<WiFi> getConnectedWiFi() {
    final _$actionInfo = _$_PetBowlCamAPIStoreActionController.startAction(
        name: '_PetBowlCamAPIStore.getConnectedWiFi');
    try {
      return super.getConnectedWiFi();
    } finally {
      _$_PetBowlCamAPIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<Timezone> getTimeZone() {
    final _$actionInfo = _$_PetBowlCamAPIStoreActionController.startAction(
        name: '_PetBowlCamAPIStore.getTimeZone');
    try {
      return super.getTimeZone();
    } finally {
      _$_PetBowlCamAPIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<Servo> getServoConfig() {
    final _$actionInfo = _$_PetBowlCamAPIStoreActionController.startAction(
        name: '_PetBowlCamAPIStore.getServoConfig');
    try {
      return super.getServoConfig();
    } finally {
      _$_PetBowlCamAPIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<TimeServer> getTimeServer() {
    final _$actionInfo = _$_PetBowlCamAPIStoreActionController.startAction(
        name: '_PetBowlCamAPIStore.getTimeServer');
    try {
      return super.getTimeServer();
    } finally {
      _$_PetBowlCamAPIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<Hardware> getHardwareInfo() {
    final _$actionInfo = _$_PetBowlCamAPIStoreActionController.startAction(
        name: '_PetBowlCamAPIStore.getHardwareInfo');
    try {
      return super.getHardwareInfo();
    } finally {
      _$_PetBowlCamAPIStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
feedingSchedulesFuture: ${feedingSchedulesFuture},
wifiFuture: ${wifiFuture},
timezoneFuture: ${timezoneFuture},
servoFuture: ${servoFuture},
timeServerFuture: ${timeServerFuture},
hardwareInfoFuture: ${hardwareInfoFuture},
serverUrlFuture: ${serverUrlFuture},
settingsIsPending: ${settingsIsPending},
settingsIsRejected: ${settingsIsRejected},
settingsIsFulfilled: ${settingsIsFulfilled}
    ''';
  }
}
