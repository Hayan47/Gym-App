import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/data/models/schedule_model.dart';

class ScheduleService {
  final _store = FirebaseFirestore.instance;

  //?add holydays
  Future<void> addMultipleHolidays(List<DateTime> dates) async {
    final CollectionReference holidayCollection = _store.collection('schedule');
    final WriteBatch batch = _store.batch();

    try {
      for (DateTime date in dates) {
        DocumentReference docRef = holidayCollection.doc();
        batch.set(docRef, {'holyday': date});
      }
      await batch.commit();
      print('Holidays added successfully');
    } catch (e) {
      print('Failed to add holidays: $e');
    }
  }

  //?get holydays
  Future<List<Schedule>> getHolidays() async {
    List<Schedule> schedules = [];
    var snapshot = await _store
        .collection('schedule')
        .withConverter<Schedule>(
          fromFirestore: Schedule.fromFirestore,
          toFirestore: (schedule, options) => schedule.toFirestore(),
        )
        .get();

    for (var doc in snapshot.docs) {
      var schedule = doc.data();
      schedules.add(schedule);
    }

    return schedules;
  }
}
