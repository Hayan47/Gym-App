import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/data/models/equipment_model.dart';

class AdminService {
  final _store = FirebaseFirestore.instance;

  //?get participants count
  Future<int> getParticipantsCount() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'participant')
        .get();

    final int count = snapshot.size;
    return count;
  }

  //?get trainers count
  Future<int> getTrainersCount() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'trainer')
        .get();

    final int count = snapshot.size;
    return count;
  }

  // //?add equipment
  // Future<void> addEquipment(Equipment equipment) async {
  //   await _store
  //       .collection('equipment')
  //       .withConverter<Equipment>(
  //         fromFirestore: Equipment.fromFirestore,
  //         toFirestore: (equipment, options) => equipment.toFirestore(),
  //       )
  //       .add(equipment);
  // }
}
