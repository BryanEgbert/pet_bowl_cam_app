import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_mqtt_store.dart';
import 'package:pet_bowl_cam_app/views/feeding_schedule_view.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_api_store.dart';
import 'package:pet_bowl_cam_app/views/notification_view.dart';
import 'package:pet_bowl_cam_app/views/settings_view.dart';

void main() {
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
    petBowlCamApiStore.initStore();
    petBowlMqttStore.connect();

    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

  @override
  void dispose() {
    petBowlMqttStore.dispose();
    super.dispose();
  }
}
