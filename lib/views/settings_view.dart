import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pet_bowl_cam_app/model/hardware.dart';
import 'package:pet_bowl_cam_app/model/servo.dart';
import 'package:pet_bowl_cam_app/model/time_server.dart';
import 'package:pet_bowl_cam_app/model/time_zone.dart';
import 'package:pet_bowl_cam_app/model/wifi.dart';
import 'package:pet_bowl_cam_app/store/settings_store.dart';
import 'package:pet_bowl_cam_app/views/edit_servo_view.dart';
import 'package:pet_bowl_cam_app/views/edit_time_server_view.dart';
import 'package:pet_bowl_cam_app/views/edit_timezone_view.dart';
import 'package:pet_bowl_cam_app/views/edit_wifi_view.dart';
import 'package:pet_bowl_cam_app/views/hardware_info_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({
    super.key,
    required this.settingsStore,
  });

  final SettingsStore settingsStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final wifiFuture = settingsStore.wifiFuture;
        final timezoneFuture = settingsStore.timezoneFuture;
        final servoFuture = settingsStore.servoFuture;
        final hardwareInfoFuture = settingsStore.hardwareInfoFuture;
        final timeServerFuture = settingsStore.timeServerFuture;

        if (settingsStore.isRejected) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Failed to load data.\nReason: ${wifiFuture.error.message}",
                ),
                IconButton(
                  onPressed: () {
                    settingsStore.initStore();
                    return;
                  },
                  icon: const Icon(Icons.refresh_rounded),
                )
              ],
            ),
          );
        } else if (settingsStore.isFulfilled) {
          WiFi wifiInfo = wifiFuture.result;
          Timezone timezoneInfo = timezoneFuture.result;
          Servo servoInfo = servoFuture.result;
          Hardware hardwareInfo = hardwareInfoFuture.result;
          TimeServer timeServerInfo = timeServerFuture.result;

          return ListView.custom(
            physics: const NeverScrollableScrollPhysics(),
            childrenDelegate: SliverChildListDelegate([
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text("Timezone"),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(timezoneInfo.tz),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTimezoneView(
                        store: settingsStore,
                        currentTimezone: timezoneInfo.tz,
                      ),
                    ),
                  );
                },
              ),
              const Divider(thickness: 0),
              ListTile(
                leading: const Icon(Icons.wifi),
                title: const Text("WiFi"),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("SSID: ${wifiInfo.ssid}"),
                      Text("IP Address: ${wifiInfo.ipAddress}"),
                      Text("DNS: ${wifiInfo.dns}"),
                      Text("Subnet: ${wifiInfo.subnetMask}"),
                      Text("MAC Address: ${wifiInfo.mac}"),
                    ],
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditWiFiView(
                        store: settingsStore, initialValue: wifiInfo),
                  ),
                ),
              ),
              const Divider(thickness: 0),
              ListTile(
                leading: const Icon(Icons.rotate_90_degrees_cw_outlined),
                title: const Text("Configure Servo"),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "Should open on request timeout: ${servoInfo.openOnTimeout}"),
                      Text(
                          "Servo Open Duration (ms): ${servoInfo.servoOpenMs}"),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditServoView(
                            store: settingsStore, initialInfo: servoInfo),
                      ));
                },
              ),
              const Divider(thickness: 0),
              ListTile(
                leading: const Icon(Icons.access_time_outlined),
                title: const Text("Configure NTP Server"),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("url 1: ${timeServerInfo.timeServer1}"),
                      Text("url 2: ${timeServerInfo.timeServer2}"),
                      Text("url 3: ${timeServerInfo.timeServer3}"),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTimeServerView(
                            timeServer1: timeServerInfo.timeServer1,
                            timeServer2: timeServerInfo.timeServer2,
                            timeServer3: timeServerInfo.timeServer3,
                            store: settingsStore),
                      ));
                },
              ),
              const Divider(thickness: 0),
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: const Text("Hardware Info"),
                subtitle:
                    const Text("Get Information about the Pet Bowl Feeder"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HardwareInfoView(hardwareInfo: hardwareInfo),
                      ));
                },
              ),
              const Divider(thickness: 0),
              ListTile(
                leading: const Icon(Icons.rotate_left_rounded),
                title: const Text("Open Servo"),
                tileColor: Colors.blueAccent,
                onTap: () {
                  settingsStore.openServo();
                },
              ),
              ListTile(
                leading: const Icon(Icons.warning_amber_rounded),
                title: const Text("Reset board"),
                tileColor: Colors.redAccent,
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Reset Board?"),
                        content: const Text(
                            "Resetting board may lead to board unable to correctly connect to WiFi and time server. Are you sure?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              settingsStore.resetBoard();
                              Navigator.pop(context);
                            },
                            child: const Text("Yes"),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No"))
                        ],
                      );
                    },
                  );
                },
              ),
            ]),
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
      },
    );
  }
}
