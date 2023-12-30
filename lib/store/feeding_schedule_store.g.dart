// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feeding_schedule_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FeedingScheduleStore on _FeedingScheduleStore, Store {
  late final _$feedingSchedulesFutureAtom = Atom(
      name: '_FeedingScheduleStore.feedingSchedulesFuture', context: context);

  @override
  ObservableFuture<List<FeedingSchedule>> get feedingSchedulesFuture {
    _$feedingSchedulesFutureAtom.reportRead();
    return super.feedingSchedulesFuture;
  }

  @override
  set feedingSchedulesFuture(ObservableFuture<List<FeedingSchedule>> value) {
    _$feedingSchedulesFutureAtom
        .reportWrite(value, super.feedingSchedulesFuture, () {
      super.feedingSchedulesFuture = value;
    });
  }

  late final _$createFeedingScheduleAsyncAction = AsyncAction(
      '_FeedingScheduleStore.createFeedingSchedule',
      context: context);

  @override
  Future<List<FeedingSchedule>> createFeedingSchedule(FeedingSchedule data) {
    return _$createFeedingScheduleAsyncAction
        .run(() => super.createFeedingSchedule(data));
  }

  late final _$updateFeedingScheduleAsyncAction = AsyncAction(
      '_FeedingScheduleStore.updateFeedingSchedule',
      context: context);

  @override
  Future<List<FeedingSchedule>> updateFeedingSchedule(
      int id, FeedingSchedule data) {
    return _$updateFeedingScheduleAsyncAction
        .run(() => super.updateFeedingSchedule(id, data));
  }

  late final _$deleteFeedingSchedulesAsyncAction = AsyncAction(
      '_FeedingScheduleStore.deleteFeedingSchedules',
      context: context);

  @override
  Future<List<FeedingSchedule>> deleteFeedingSchedules(int index) {
    return _$deleteFeedingSchedulesAsyncAction
        .run(() => super.deleteFeedingSchedules(index));
  }

  late final _$_FeedingScheduleStoreActionController =
      ActionController(name: '_FeedingScheduleStore', context: context);

  @override
  Future<List<FeedingSchedule>> getFeedingSchedules() {
    final _$actionInfo = _$_FeedingScheduleStoreActionController.startAction(
        name: '_FeedingScheduleStore.getFeedingSchedules');
    try {
      return super.getFeedingSchedules();
    } finally {
      _$_FeedingScheduleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
feedingSchedulesFuture: ${feedingSchedulesFuture}
    ''';
  }
}
