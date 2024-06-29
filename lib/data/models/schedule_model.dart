import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String? scheduleId;
  final DateTime holyday;

  Schedule({
    this.scheduleId,
    required this.holyday,
  });

  factory Schedule.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Schedule(
      scheduleId: snapshot.id,
      holyday: (data?['holyday'] as Timestamp).toDate(),
    );
  }

  // toFirestore method
  Map<String, dynamic> toFirestore() {
    return {
      'holyday': holyday,
    };
  }
}
