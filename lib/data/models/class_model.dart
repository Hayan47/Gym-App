class GymClass {
  final String name;
  final String instructor;
  final String description;
  final String schedule;
  final String duration;
  final String location;
  final String difficulty;
  final int capacity;
  final bool isAvailable;
  final String signUpLink;
  final List<String> equipmentNeeded;
  final List<String> specialInstructions;

  GymClass({
    required this.name,
    required this.instructor,
    required this.description,
    required this.schedule,
    required this.duration,
    required this.location,
    required this.difficulty,
    required this.capacity,
    required this.isAvailable,
    required this.signUpLink,
    required this.equipmentNeeded,
    required this.specialInstructions,
  });
}

List<GymClass> gymClasses = [
  GymClass(
    name: 'Yoga',
    instructor: 'Jane Doe',
    description:
        'A calming class focused on improving flexibility and mindfulness through various yoga poses and breathing exercises.',
    schedule: 'Monday, Wednesday, Friday at 7 AM',
    duration: '1 hour',
    location: 'Studio A',
    difficulty: 'Beginner',
    capacity: 20,
    isAvailable: true,
    signUpLink: 'https://example.com/signup/yoga',
    equipmentNeeded: ['Yoga mat', 'Water bottle'],
    specialInstructions: [
      'Arrive 10 minutes early to set up your mat.',
      'Wear comfortable, stretchy clothing.'
    ],
  ),
  GymClass(
    name: 'Spinning',
    instructor: 'John Smith',
    description:
        'A high-intensity class using stationary bikes to simulate outdoor cycling.',
    schedule: 'Tuesday, Thursday at 6 PM',
    duration: '45 minutes',
    location: 'Studio B',
    difficulty: 'Intermediate',
    capacity: 15,
    isAvailable: false, // Class is full
    signUpLink: 'https://example.com/signup/spinning',
    equipmentNeeded: ['Water bottle', 'Towel'],
    specialInstructions: [
      'Arrive early to adjust your bike settings.',
      'Wear comfortable workout clothes and cycling shoes if available.'
    ],
  ),
  GymClass(
    name: 'HIIT',
    instructor: 'Alice Johnson',
    description:
        'High-Intensity Interval Training to burn calories and improve fitness.',
    schedule: 'Saturday at 9 AM',
    duration: '30 minutes',
    location: 'Main Hall',
    difficulty: 'Advanced',
    capacity: 25,
    isAvailable: true,
    signUpLink: 'https://example.com/signup/hiit',
    equipmentNeeded: ['Water bottle', 'Towel'],
    specialInstructions: [
      'Be prepared for intense exercise.',
      'Wear appropriate footwear.'
    ],
  ),
  // Add more classes as needed
];
