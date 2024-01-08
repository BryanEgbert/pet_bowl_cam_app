// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_bowl_cam_mqtt_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetBowlCamMqttStore on _PetBowlCamMqttStore, Store {
  late final _$mqttStreamAtom =
      Atom(name: '_PetBowlCamMqttStore.mqttStream', context: context);

  @override
  ObservableStream<List<MqttReceivedMessage<MqttMessage>>>? get mqttStream {
    _$mqttStreamAtom.reportRead();
    return super.mqttStream;
  }

  @override
  set mqttStream(
      ObservableStream<List<MqttReceivedMessage<MqttMessage>>>? value) {
    _$mqttStreamAtom.reportWrite(value, super.mqttStream, () {
      super.mqttStream = value;
    });
  }

  late final _$mqttClientAtom =
      Atom(name: '_PetBowlCamMqttStore.mqttClient', context: context);

  @override
  MqttServerClient? get mqttClient {
    _$mqttClientAtom.reportRead();
    return super.mqttClient;
  }

  @override
  set mqttClient(MqttServerClient? value) {
    _$mqttClientAtom.reportWrite(value, super.mqttClient, () {
      super.mqttClient = value;
    });
  }

  late final _$connStatusFutureAtom =
      Atom(name: '_PetBowlCamMqttStore.connStatusFuture', context: context);

  @override
  ObservableFuture<MqttClientConnectionStatus?> get connStatusFuture {
    _$connStatusFutureAtom.reportRead();
    return super.connStatusFuture;
  }

  @override
  set connStatusFuture(ObservableFuture<MqttClientConnectionStatus?> value) {
    _$connStatusFutureAtom.reportWrite(value, super.connStatusFuture, () {
      super.connStatusFuture = value;
    });
  }

  late final _$connectAsyncAction =
      AsyncAction('_PetBowlCamMqttStore.connect', context: context);

  @override
  Future<MqttClientConnectionStatus?> connect() {
    return _$connectAsyncAction.run(() => super.connect());
  }

  @override
  String toString() {
    return '''
mqttStream: ${mqttStream},
mqttClient: ${mqttClient},
connStatusFuture: ${connStatusFuture}
    ''';
  }
}
