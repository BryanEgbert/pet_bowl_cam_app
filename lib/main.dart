import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
// ignore: implementation_imports
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';
import 'package:pet_bowl_cam_app/model/mqtt_server.dart';
import 'package:pet_bowl_cam_app/service/mqtt_service.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_mqtt_store.dart';
import 'package:pet_bowl_cam_app/views/feeding_schedule_view.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_api_store.dart';
import 'package:pet_bowl_cam_app/views/notification_view.dart';
import 'package:pet_bowl_cam_app/views/settings_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     final MqttService mqttService = MqttService(
//       clientId: DateTime.now().millisecondsSinceEpoch.toString(),
//       property: MqttServerProperty(
//         host: prefs.getString("mqttHost") ?? "127.0.0.1",
//         port: prefs.getInt("mqttPort") ?? 1883,
//         topic: prefs.getString("mqttTopic") ?? "topic/queue",
//         username: prefs.getString("mqttUsername"),
//         password: prefs.getString("mqttPassword"),
//       ),
//     );

//     final client = mqttService.connect();
//     await client.connect();
//     client.subscribe(
//         prefs.getString("mqttTopic") ?? "topic/queue", MqttQos.atLeastOnce);

//     while (true) {
//       client.updates?.listen((event) {
//         final message = event[0].payload as MqttPublishMessage;

//         print(
//             "${event[0].topic} - ${MqttPublishPayload.bytesToStringAsString(message.payload.message)}");
//         Future.delayed(const Duration(seconds: 5));
//       });
//     }

//     return Future.value(true);
//   });
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Workmanager().initialize(
  //   callbackDispatcher,
  //   isInDebugMode: true,
  // );
  // Workmanager().registerOneOffTask("task-identifier", "mqttListener",
  //     constraints: Constraints(networkType: NetworkType.connected));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PetBowlCamAPIStore petBowlCamApiStore = PetBowlCamAPIStore();
  final PetBowlCamMqttStore petBowlMqttStore = PetBowlCamMqttStore();

  int _selectedIndex = 0;

  @override
  void initState() {
    petBowlMqttStore.connect();
    petBowlCamApiStore.initStore();

    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // petBowlCamApiStore.initStore();
    petBowlCamApiStore.initStore();

    List<Widget> widgets = [
      FeedingScheduleView(store: petBowlCamApiStore),
      SettingsView(
        store: petBowlCamApiStore,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("PetBowlCam App"),
        backgroundColor: Colors.amberAccent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NotificationView(store: petBowlMqttStore),
                    ));
              },
              icon: const Icon(Icons.notifications_rounded)),
          IconButton(
              onPressed: () => setState(() {
                    petBowlCamApiStore.initStore();
                  }),
              icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      body: SafeArea(child: widgets[_selectedIndex]),
      floatingActionButton: FloatingActionButton.large(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const CircleBorder(),
          mouseCursor: SystemMouseCursors.click,
          onPressed: () async {
            final TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              orientation: Orientation.portrait,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                );
              },
            );

            if (time == null) return;

            FeedingSchedule newData = FeedingSchedule(
                hour: time.hour, minutes: time.minute, seconds: 0);

            petBowlCamApiStore.createFeedingSchedule(newData);
          },
          child: const Icon(
            Icons.add,
            color: Colors.red,
            size: 48.0,
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() => _selectedIndex = value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Feeding Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
