import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
// ignore: implementation_imports
import 'package:mobx/src/api/async.dart';
import 'package:pet_bowl_cam_app/edit_servo.dart';
import 'package:pet_bowl_cam_app/edit_time_server.dart';
import 'package:pet_bowl_cam_app/edit_timezone.dart';
import 'package:pet_bowl_cam_app/edit_wifi.dart';
import 'package:pet_bowl_cam_app/hardware_info.dart';
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';
import 'package:pet_bowl_cam_app/model/hardware.dart';
import 'package:pet_bowl_cam_app/model/servo.dart';
import 'package:pet_bowl_cam_app/model/time_server.dart';
import 'package:pet_bowl_cam_app/model/time_zone.dart';
import 'package:pet_bowl_cam_app/model/wifi.dart';
import 'package:pet_bowl_cam_app/store/feeding_schedule_store.dart';
import 'package:pet_bowl_cam_app/store/settings_store.dart';

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
  final FeedingScheduleStore feedingScheduleStore = FeedingScheduleStore();
  final SettingsStore settingsStore = SettingsStore();

  int _selectedIndex = 0;

  @override
  void initState() {
    feedingScheduleStore.getFeedingSchedules();
    settingsStore.initStore();
    _selectedIndex = widget.selectedIndex;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      FeedingScheduleView(store: feedingScheduleStore),
      SettingsView(
        settingsStore: settingsStore,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("PetBowlCam App"),
        backgroundColor: Colors.amberAccent,
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

            feedingScheduleStore.createFeedingSchedule(newData);
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
                  "Failed to load data.\nReason: ${wifiFuture.error}",
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

class FeedingScheduleView extends StatelessWidget {
  const FeedingScheduleView({
    super.key,
    required this.store,
  });

  final FeedingScheduleStore store;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final future = store.feedingSchedulesFuture;

      switch (future.status) {
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
                const Text(
                  "Failed to load data",
                ),
                Text("Reason: ${future.error.message}"),
                IconButton(
                  onPressed: () {
                    store.getFeedingSchedules();
                    return;
                  },
                  icon: const Icon(Icons.refresh_rounded),
                )
              ],
            ),
          );
        case FutureStatus.fulfilled:
          List<FeedingSchedule> feedingSchedules = future.result;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Feeding Schedules",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      "${feedingSchedules.length}/5",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    store.getFeedingSchedules();

                    return Future(() => null);
                  },
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: feedingSchedules.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete_forever),
                        ),
                        secondaryBackground: Container(
                          color: Colors.redAccent,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.delete_forever, size: 48.0),
                            ],
                          ),
                        ),
                        onDismissed: (_) {
                          store.deleteFeedingSchedules(index + 1);
                        },
                        child: InkWell(
                          child: ListTile(
                            title: Text(
                              store.timeString(feedingSchedules[index]),
                              style: const TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.w400),
                            ),
                            trailing: const Icon(Icons.edit),
                          ),
                          onTap: () async {
                            final TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                  hour: feedingSchedules[index].hour,
                                  minute: feedingSchedules[index].minutes),
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

                            store.updateFeedingSchedule(
                                index + 1,
                                FeedingSchedule(
                                    hour: time.hour,
                                    minutes: time.minute,
                                    seconds: 0));
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                ),
              ),
            ],
          );

        default:
          return const Center(
            child: Text("Something's wrong"),
          );
      }
    });
  }
}
