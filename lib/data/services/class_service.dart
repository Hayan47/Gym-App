import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/data/models/class_model.dart';

class ClassService {
  final _store = FirebaseFirestore.instance;

  //?get all classes
  Future<List<GymClass>> getAllClasses() async {
    List<GymClass> classes = [];
    var snapshot = await _store
        .collection('gymclass')
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
}
