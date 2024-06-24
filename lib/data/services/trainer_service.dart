import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/data/models/usr_model.dart';

class TrainerService {
  final _store = FirebaseFirestore.instance;

  //?get all trainers
  Future<List<Trainer>> getAllTrainers() async {
    List<Trainer> trainers = [];
    var snapshot = await _store
        .collection('users')
        .where('role', isEqualTo: 'trainer')
        .get();

    for (var userDoc in snapshot.docs) {
      // Get the trainer details from the 'details' subcollection
      var roleDoc =
          await userDoc.reference.collection('details').doc('trainer').get();

      if (roleDoc.exists) {
        trainers.add(Trainer.fromFirestore(userDoc, roleDoc));
      }
    }
    return trainers;
  }
}
