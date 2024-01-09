// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_bowl_cam_mqtt_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PetBowlCamMqttStore on _PetBowlCamMqttStore, Store {
  late final _$messagesAtom =
      Atom(name: '_PetBowlCamMqttStore.messages', context: context);

  @override
  ObservableList<MqttReceivedMessage<MqttMessage>>? get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<MqttReceivedMessage<MqttMessage>>? value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
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

  late final _$connectAsyncAction =
      AsyncAction('_PetBowlCamMqttStore.connect', context: context);

  @override
  Future<void> connect() {
    return _$connectAsyncAction.run(() => super.connect());
  }

  @override
  String toString() {
    return '''
messages: ${messages},
mqttClient: ${mqttClient}
    ''';
  }
}
