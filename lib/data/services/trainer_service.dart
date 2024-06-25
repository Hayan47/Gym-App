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

  //?rate trainer
  Future<void> rateTrainer(
      String trainerId, String userId, double rating) async {
    // Create a new rating document
    final ratingDoc = _store
        .collection('users')
        .doc(trainerId)
        .collection('ratings')
        .doc(userId);

    // Add or update the rating
    await ratingDoc.set({
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update the trainer's average rating
    await _updateTrainerRating(trainerId);
  }

  Future<void> _updateTrainerRating(String trainerId) async {
    // Get all ratings for the trainer
    final ratingsSnapshot = await _store
        .collection('users')
        .doc(trainerId)
        .collection('ratings')
        .get();

    // if (ratingsSnapshot.docs.isEmpty) return;

    // Calculate the new average rating
    double totalRating = 0;
    int numberOfRatings = ratingsSnapshot.docs.length;

    for (var doc in ratingsSnapshot.docs) {
      totalRating += doc.data()['rating'];
    }

    double averageRating = totalRating / numberOfRatings;

    // Update the trainer document with the new average rating and number of ratings
    await _store
        .collection('users')
        .doc(trainerId)
        .collection('details')
        .doc('trainer')
        .update({
      'rating': averageRating,
      'numberOfRatings': numberOfRatings,
    });
  }
}
