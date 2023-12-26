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

  late final _$isResponseSuccessAtom =
      Atom(name: '_FeedingScheduleStore.isResponseSuccess', context: context);

  @override
  ObservableFuture<bool>? get isResponseSuccess {
    _$isResponseSuccessAtom.reportRead();
    return super.isResponseSuccess;
  }

  @override
  set isResponseSuccess(ObservableFuture<bool>? value) {
    _$isResponseSuccessAtom.reportWrite(value, super.isResponseSuccess, () {
      super.isResponseSuccess = value;
    });
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
  Future<List<FeedingSchedule>> deleteFeedingSchedules(int index) {
    final _$actionInfo = _$_FeedingScheduleStoreActionController.startAction(
        name: '_FeedingScheduleStore.deleteFeedingSchedules');
    try {
      return super.deleteFeedingSchedules(index);
    } finally {
      _$_FeedingScheduleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
feedingSchedulesFuture: ${feedingSchedulesFuture},
isResponseSuccess: ${isResponseSuccess}
    ''';
  }
}
