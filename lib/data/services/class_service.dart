import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/data/models/class_model.dart';

class ClassService {
  final _store = FirebaseFirestore.instance;

  //?get all classes
  Future<List<GymClass>> getAllClasses() async {
    List<GymClass> classes = [];
    var snapshot = await _store
        .collection('gymclass')
        .where('state', isEqualTo: "approved")
        .withConverter<GymClass>(
          fromFirestore: GymClass.fromFirestore,
          toFirestore: (gymclass, options) => gymclass.toFirestore(),
        )
        .get();

    for (var doc in snapshot.docs) {
      var gymclass = doc.data();
      classes.add(gymclass);
    }
    return classes;
  }

  //?add class
  Future<void> addClass(GymClass gymclass) async {
    await _store
        .collection('gymclass')
        .withConverter<GymClass>(
          fromFirestore: GymClass.fromFirestore,
          toFirestore: (gymclass, options) => gymclass.toFirestore(),
        )
        .add(gymclass);
  }

  //?delete class
  Future<void> deleteClass(GymClass gymclass) async {
    await _store
        .collection('deletedgymclass')
        .withConverter<GymClass>(
          fromFirestore: GymClass.fromFirestore,
          toFirestore: (gymclass, options) => gymclass.toFirestore(),
        )
        .add(gymclass);
    await _store
        .collection('gymclass')
        .withConverter<GymClass>(
          fromFirestore: GymClass.fromFirestore,
          toFirestore: (gymclass, options) => gymclass.toFirestore(),
        )
        .doc(gymclass.classid)
        .delete();
  }

  //?get trainer classes
  Future<List<GymClass>> getTrainerClasses(String trainerId) async {
    List<GymClass> classes = [];
    var snapshot = await _store
        .collection('gymclass')
        .where('trainerId', isEqualTo: trainerId)
        .withConverter<GymClass>(
          fromFirestore: GymClass.fromFirestore,
          toFirestore: (gymclass, options) => gymclass.toFirestore(),
        )
        .get();

    for (var doc in snapshot.docs) {
      var gymclass = doc.data();
      classes.add(gymclass);
    }
    return classes;
  }

  //?get participant classes
  Future<List<GymClass>> getParticipantClasses(String participantId) async {
    List<String> enrolledClassesIds = [];
    List<GymClass> enrolledClasses = [];
    var snapshot = await _store
        .collection('users')
        .doc(participantId)
        .collection('details')
        .doc('participant')
        .get();

    enrolledClassesIds = List<String>.from(snapshot.data()!['enrolledClasses']);

    if (enrolledClassesIds.isEmpty) {
      return [];
    }

    enrolledClasses = await getClassesByIds(enrolledClassesIds);

    return enrolledClasses;
  }

  //? join class
  Future<void> joinClass(String classId, String userId) async {
    final DocumentReference userDocRef = _store.collection('users').doc(userId);
    final DocumentReference classDocRef =
        _store.collection('gymclass').doc(classId);

    // Run the updates in a transaction to ensure atomicity
    await _store.runTransaction((transaction) async {
      // Add user ID to the class members list
      transaction.update(classDocRef, {
        'memberIds': FieldValue.arrayUnion([userId]),
      });

      // Add class ID to the user's enrolled classes list
      transaction.update(userDocRef.collection('details').doc('participant'), {
        'enrolledClasses': FieldValue.arrayUnion([classId]),
      });
    });
  }

  Future<List<GymClass>> getClassesByIds(List<String> classIds) async {
    List<GymClass> classes = [];

    var snapshot = await _store
        .collection('gymclass')
        .where(FieldPath.documentId, whereIn: classIds)
        .withConverter<GymClass>(
          fromFirestore: GymClass.fromFirestore,
          toFirestore: (gymclass, options) => gymclass.toFirestore(),
        )
        .get();

    for (var doc in snapshot.docs) {
      var gymclass = doc.data();
      classes.add(gymclass);
    }

    return classes;
  }

  //?get pending classes
  Future<List<GymClass>> getPendingClasses() async {
    List<GymClass> classes = [];
    var snapshot = await _store
        .collection('gymclass')
        .where('state', isEqualTo: "pending")
        .withConverter<GymClass>(
          fromFirestore: GymClass.fromFirestore,
          toFirestore: (gymclass, options) => gymclass.toFirestore(),
        )
        .get();

    for (var doc in snapshot.docs) {
      var gymclass = doc.data();
      classes.add(gymclass);
    }
    return classes;
  }

  //?update class state
  Future<void> updateGymClassState(String gymClassId, String newState) async {
    var docRef = _store.collection('gymclass').doc(gymClassId);
    await docRef.update({'state': newState});
  }
}
