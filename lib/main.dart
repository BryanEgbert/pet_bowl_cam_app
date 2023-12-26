import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/src/api/async.dart';
import 'package:pet_bowl_cam_app/store/feeding_schedule_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FeedingScheduleStore store = FeedingScheduleStore();

  int _selectedIndex = 0;

  @override
  void initState() {
    store.getFeedingSchedules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      FeedingScheduleView(store: store),
      const Center(
        child: Text("settings"),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("PetBowlCam App"),
        backgroundColor: Colors.amberAccent,
      ),
      body: SafeArea(child: widgets[_selectedIndex]),
      floatingActionButton: FloatingActionButton.large(onPressed: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          orientation: Orientation.portrait,
          builder: (context, child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) => {setState(() => _selectedIndex = value)},
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
          return const Center(
            child: Text(
              "Failed to load data. Are your esp32cam turned on?",
            ),
          );
        case FutureStatus.fulfilled:
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
                      "${future.result.length}/5",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: future.result.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        store.deleteFeedingSchedules(index + 1);
                      },
                      child: InkWell(
                        child: ListTile(
                          title: Text(
                            store.timeString(future.result[index]),
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w400),
                          ),
                          trailing: const Icon(Icons.edit),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
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
