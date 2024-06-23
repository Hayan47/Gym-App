import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/data/models/equipment_model.dart';

class EquipmentService {
  final _store = FirebaseFirestore.instance;

  //?get all equipment
  Future<List<Equipment>> getAllEquipment() async {
    List<Equipment> equipmentList = [];
    var snapshot = await _store
        .collection('equipment')
        .withConverter<Equipment>(
          fromFirestore: Equipment.fromFirestore,
          toFirestore: (equipment, options) => equipment.toFirestore(),
        )
        .get();

    for (var doc in snapshot.docs) {
      var equipment = doc.data();
      equipmentList.add(equipment);
    }
    return equipmentList;
  }

  //?add equipment
  Future<void> addEquipment(Equipment equipment) async {
    await _store
        .collection('equipment')
        .withConverter<Equipment>(
          fromFirestore: Equipment.fromFirestore,
          toFirestore: (equipment, options) => equipment.toFirestore(),
        )
        .add(equipment);
  }

  //?delete equipment
  Future<void> deleteEquipment(Equipment equipment) async {
    await _store
        .collection('deletedEquipment')
        .withConverter<Equipment>(
          fromFirestore: Equipment.fromFirestore,
          toFirestore: (equipment, options) => equipment.toFirestore(),
        )
        .add(equipment);
    await _store
        .collection('equipment')
        .withConverter<Equipment>(
          fromFirestore: Equipment.fromFirestore,
          toFirestore: (equipment, options) => equipment.toFirestore(),
        )
        .doc(equipment.equipmentid)
        .delete();
  }
}
