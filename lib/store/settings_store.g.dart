// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsStore on _SettingsStore, Store {
  Computed<bool>? _$isPendingComputed;

  @override
  bool get isPending =>
      (_$isPendingComputed ??= Computed<bool>(() => super.isPending,
              name: '_SettingsStore.isPending'))
          .value;
  Computed<bool>? _$isRejectedComputed;

  @override
  bool get isRejected =>
      (_$isRejectedComputed ??= Computed<bool>(() => super.isRejected,
              name: '_SettingsStore.isRejected'))
          .value;
  Computed<bool>? _$isFulfilledComputed;

  @override
  bool get isFulfilled =>
      (_$isFulfilledComputed ??= Computed<bool>(() => super.isFulfilled,
              name: '_SettingsStore.isFulfilled'))
          .value;

  late final _$wifiFutureAtom =
      Atom(name: '_SettingsStore.wifiFuture', context: context);

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
      Atom(name: '_SettingsStore.timezoneFuture', context: context);

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

  late final _$_SettingsStoreActionController =
      ActionController(name: '_SettingsStore', context: context);

  @override
  Future<WiFi> getConnectedWiFi() {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(
        name: '_SettingsStore.getConnectedWiFi');
    try {
      return super.getConnectedWiFi();
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<Timezone> getTimeZone() {
    final _$actionInfo = _$_SettingsStoreActionController.startAction(
        name: '_SettingsStore.getTimeZone');
    try {
      return super.getTimeZone();
    } finally {
      _$_SettingsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
wifiFuture: ${wifiFuture},
timezoneFuture: ${timezoneFuture},
isPending: ${isPending},
isRejected: ${isRejected},
isFulfilled: ${isFulfilled}
    ''';
  }
}
