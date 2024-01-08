import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/src/api/async.dart';
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
            final connStatusFuture = widget.store.connStatusFuture;

            switch (connStatusFuture.status) {
              case FutureStatus.pending:
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator.adaptive(),
                      Text("Fetching data..."),
                    ],
                  ),
                );
              case FutureStatus.rejected:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Failed to load data.\nReason: ${connStatusFuture.error}",
                      ),
                      IconButton(
                        onPressed: () {
                          widget.store.connect();
                          return;
                        },
                        icon: const Icon(Icons.refresh_rounded),
                      )
                    ],
                  ),
                );
              case FutureStatus.fulfilled:
                final connStatus = connStatusFuture.value;
                if (connStatus?.state == MqttConnectionState.connected) {
                  widget.store.listen();
                  return ListView.builder(
                    itemCount: widget.store.mqttStream?.value?.length ?? 0,
                    itemBuilder: (context, index) {
                      final value = widget.store.mqttStream?.value;

                      return ListTile(
                        title: Text(MqttPublishPayload.bytesToStringAsString(
                            (value![index].payload as MqttPublishMessage)
                                .payload
                                .message)),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator.adaptive(),
                        Text("Fetching data..."),
                      ],
                    ),
                  );
                }
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
