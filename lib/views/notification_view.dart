import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_mqtt_store.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key, required this.store});

  final PetBowlCamMqttStore store;

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("PetBowlCam App"),
          backgroundColor: Colors.amberAccent,
        ),
        body: Observer(
          builder: (context) {
            if (widget.store.mqttClient == null) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    Text("Fetching data..."),
                  ],
                ),
              );
            } else {
              return ListView.separated(
                itemCount: widget.store.messages?.length ?? 0,
                itemBuilder: (context, index) {
                  // final value = widget.store.mqttStream?.value;

                  return ListTile(
                    title: Text(MqttPublishPayload.bytesToStringAsString((widget
                            .store
                            .messages?[index]
                            .payload as MqttPublishMessage)
                        .payload
                        .message)),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.store.dispose();
    super.dispose();
  }
}
