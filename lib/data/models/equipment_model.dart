import 'package:cloud_firestore/cloud_firestore.dart';

class Equipment {
  final String? equipmentid;
  final String name;
  final String imagePath;
  final String description;
  final String location;
  final String usageInstructions;
  final List<String> safetyTips;
  final List<String> tutorialLinks;

  Equipment({
    this.equipmentid,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.location,
    required this.usageInstructions,
    required this.safetyTips,
    required this.tutorialLinks,
  });

  // fromFirestore factory constructor
  factory Equipment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Equipment(
      equipmentid: snapshot.id,
      name: data?['name'],
      imagePath: data?['imagePath'],
      description: data?['description'],
      location: data?['location'],
      usageInstructions: data?['usageInstructions'],
      safetyTips: List<String>.from(data?['safetyTips'] ?? []),
      tutorialLinks: List<String>.from(data?['tutorialLinks'] ?? []),
    );
  }

  // toFirestore method
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'imagePath': imagePath,
      'description': description,
      'location': location,
      'usageInstructions': usageInstructions,
      'safetyTips': safetyTips,
      'tutorialLinks': tutorialLinks,
    };
  }
}

// Example data
List<Equipment> gymEquipment = [
  Equipment(
    equipmentid: "sdf",
    name: 'Treadmill',
    imagePath: 'assets/img/treadmill.png',
    description: 'A machine for walking or running while staying in one place.',
    location: 'Cardio Section',
    usageInstructions: 'Start slow and increase speed gradually.',
    safetyTips: ['Wear proper running shoes.', 'Use the safety key.'],
    tutorialLinks: [
      'https://example.com/treadmill-usage',
      'https://example.com/treadmill-safety'
    ],
  ),
  // Add more equipment here
];
