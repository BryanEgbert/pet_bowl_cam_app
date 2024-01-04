import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';
import 'package:pet_bowl_cam_app/store/feeding_schedule_store.dart';

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
