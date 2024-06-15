class Equipment {
  final String name;
  final String imagePath;
  final String description;
  final String location;
  final String usageInstructions;
  final List<String> safetyTips;
  final List<String> tutorialLinks;

  Equipment({
    required this.name,
    required this.imagePath,
    required this.description,
    required this.location,
    required this.usageInstructions,
    required this.safetyTips,
    required this.tutorialLinks,
  });
}

// Example data
List<Equipment> gymEquipment = [
  Equipment(
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
