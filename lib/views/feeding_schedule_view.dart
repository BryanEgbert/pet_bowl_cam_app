import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_api_store.dart';
import 'package:pet_bowl_cam_app/views/error_view.dart';

class FeedingScheduleView extends StatelessWidget {
  const FeedingScheduleView({
    super.key,
    required this.store,
  });

  final PetBowlCamAPIStore store;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final future = store.feedingSchedulesFuture;

      if (future.status == FutureStatus.rejected) {
        return ErrorView(
            errorMessage: future.error.message,
            refreshCallback: () {
              store.initStore();
            });
      } else if (future.status == FutureStatus.fulfilled) {
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
                  store.initStore();

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
                            feedingSchedules[index].toString(),
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
      } else {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator.adaptive(),
              Text("Fetching data..."),
              Text(
                "Note: The first time you open the app,\npress the refresh button for the load to complete",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
    });
  }
}
