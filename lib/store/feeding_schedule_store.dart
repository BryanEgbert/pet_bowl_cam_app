import 'package:mobx/mobx.dart';
import 'package:pet_bowl_cam_app/api/pet_bowl_cam_api.dart';
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';

part 'feeding_schedule_store.g.dart';

class FeedingScheduleStore = _FeedingScheduleStore with _$FeedingScheduleStore;

abstract class _FeedingScheduleStore with Store {
  final PetBowlCamAPI _pbcApi = PetBowlCamAPI();

  @observable
  ObservableFuture<List<FeedingSchedule>> feedingSchedulesFuture =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<bool>? isResponseSuccess;

  @action
  Future<List<FeedingSchedule>> getFeedingSchedules() =>
      feedingSchedulesFuture = ObservableFuture(_pbcApi.getFeedingSchedules());

  @action
  Future<List<FeedingSchedule>> deleteFeedingSchedules(int index) =>
      feedingSchedulesFuture =
          ObservableFuture(_pbcApi.deleteFeedingSchedule(index));

  String timeString(FeedingSchedule schedule) =>
      "${schedule.hour}:${schedule.minutes}";
}
