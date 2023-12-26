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

  @action
  Future<List<FeedingSchedule>> getFeedingSchedules() =>
      feedingSchedulesFuture = ObservableFuture(_pbcApi.getFeedingSchedules());

  @action
  Future<List<FeedingSchedule>> createFeedingSchedule(
      FeedingSchedule data) async {
    bool success = await _pbcApi.createFeedingSchedule(data);

    feedingSchedulesFuture = ObservableFuture(_pbcApi.getFeedingSchedules());

    return _pbcApi.getFeedingSchedules();
  }

  @action
  Future<List<FeedingSchedule>> deleteFeedingSchedules(int index) async {
    bool success = await _pbcApi.deleteFeedingSchedule(index);

    feedingSchedulesFuture = ObservableFuture(_pbcApi.getFeedingSchedules());

    return _pbcApi.getFeedingSchedules();
  }

  String timeString(FeedingSchedule schedule) =>
      "${schedule.hour}:${schedule.minutes}";
}
