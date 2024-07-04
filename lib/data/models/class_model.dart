import 'package:cloud_firestore/cloud_firestore.dart';

class GymClass {
  final String? classid;
  final String name;
  final String imagePath;
  final String instructor;
  final String description;
  final String schedule;
  final String duration;
  final String location;
  final String difficulty;
  final int capacity;
  final List<String> equipmentNeeded;
  final List<String> specialInstructions;
  final String trainerId;
  final List<String> memberIds;
  final String state;

  GymClass({
    this.classid,
    required this.name,
    required this.imagePath,
    required this.instructor,
    required this.description,
    required this.schedule,
    required this.duration,
    required this.location,
    required this.difficulty,
    required this.capacity,
    required this.equipmentNeeded,
    required this.specialInstructions,
    required this.trainerId,
    required this.memberIds,
    required this.state,
  });

  // fromFirestore factory constructor
  factory GymClass.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return GymClass(
      classid: snapshot.id,
      name: data?['name'],
      imagePath: data?['imagePath'],
      instructor: data?['instructor'],
      description: data?['description'],
      schedule: data?['schedule'],
      duration: data?['duration'],
      location: data?['location'],
      difficulty: data?['difficulty'],
      capacity: data?['capacity'],
      equipmentNeeded: List<String>.from(data?['equipmentNeeded'] ?? []),
      specialInstructions:
          List<String>.from(data?['specialInstructions'] ?? []),
      trainerId: data?['trainerId'],
      memberIds: List<String>.from(data?['memberIds'] ?? []),
      state: data?['state'],
    );
  }

  // toFirestore method
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'imagePath': imagePath,
      'instructor': instructor,
      'description': description,
      'schedule': schedule,
      'duration': duration,
      'location': location,
      'difficulty': difficulty,
      'capacity': capacity,
      'equipmentNeeded': equipmentNeeded,
      'specialInstructions': specialInstructions,
      'trainerId': trainerId,
      'memberIds': memberIds,
      'state': state,
    };
  }
}

// List<GymClass> gymClasses = [
  // GymClass(
  //   name: 'Yoga',
  //   instructor: 'Jane Doe',
  //   description:
  //       'A calming class focused on improving flexibility and mindfulness through various yoga poses and breathing exercises.',
  //   schedule: 'Monday, Wednesday, Friday at 7 AM',
  //   duration: '1 hour',
  //   location: 'Studio A',
  //   difficulty: 'Beginner',
  //   capacity: 20,
  //   isAvailable: true,
  //   signUpLink: 'https://example.com/signup/yoga',
  //   equipmentNeeded: ['Yoga mat', 'Water bottle'],
  //   specialInstructions: [
  //     'Arrive 10 minutes early to set up your mat.',
  //     'Wear comfortable, stretchy clothing.'
  //   ],
  // ),
  // GymClass(
  //   name: 'Spinning',
  //   instructor: 'John Smith',
  //   description:
  //       'A high-intensity class using stationary bikes to simulate outdoor cycling.',
  //   schedule: 'Tuesday, Thursday at 6 PM',
  //   duration: '45 minutes',
  //   location: 'Studio B',
  //   difficulty: 'Intermediate',
  //   capacity: 15,
  //   isAvailable: false, // Class is full
  //   signUpLink: 'https://example.com/signup/spinning',
  //   equipmentNeeded: ['Water bottle', 'Towel'],
  //   specialInstructions: [
  //     'Arrive early to adjust your bike settings.',
  //     'Wear comfortable workout clothes and cycling shoes if available.'
  //   ],
  // ),
  // GymClass(
  //   name: 'HIIT',
  //   instructor: 'Alice Johnson',
  //   description:
  //       'High-Intensity Interval Training to burn calories and improve fitness.',
  //   schedule: 'Saturday at 9 AM',
  //   duration: '30 minutes',
  //   location: 'Main Hall',
  //   difficulty: 'Advanced',
  //   capacity: 25,
  //   isAvailable: true,
  //   signUpLink: 'https://example.com/signup/hiit',
  //   equipmentNeeded: ['Water bottle', 'Towel'],
  //   specialInstructions: [
  //     'Be prepared for intense exercise.',
  //     'Wear appropriate footwear.'
  //   ],
  // ),
  // Add more classes as needed
// ];
