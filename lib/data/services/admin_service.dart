import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  final _store = FirebaseFirestore.instance;

  //?get participants count
  Future<int> getParticipantsCount() async {
    var snapshot = await _store
        .collection('users')
        .where('role', isEqualTo: 'participant')
        .get();

    final int count = snapshot.size;
    return count;
  }

  //?get trainers count
  Future<int> getTrainersCount() async {
    var snapshot = await _store
        .collection('users')
        .where('role', isEqualTo: 'trainer')
        .get();

    final int count = snapshot.size;
    return count;
  }
}
