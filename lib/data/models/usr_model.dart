import 'package:cloud_firestore/cloud_firestore.dart';

class Usr {
  String userid;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String? profilePicture;
  int age;
  String gender;
  String role;

  Usr({
    required this.userid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profilePicture,
    required this.age,
    required this.gender,
    required this.role,
  });

  factory Usr.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Usr(
      userid: snapshot.reference.id,
      firstName: data?['first name'],
      lastName: data?['last name'],
      email: data?['email'],
      age: data?['age'],
      profilePicture: data?['profilePicture'],
      phoneNumber: data?['phoneNumber'],
      gender: data?['gender'],
      role: data?['role'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "age": age,
      "phoneNumber": phoneNumber,
      if (profilePicture != null) "profilePicture": profilePicture,
      "gender": gender,
      "role": role,
    };
  }
}

class Admin extends Usr {
  Admin({
    required super.userid,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.age,
    required super.phoneNumber,
    required super.profilePicture,
    required super.role,
    required super.gender,
  });

  factory Admin.fromFirestore(DocumentSnapshot<Map<String, dynamic>> userDoc) {
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    // Map<String, dynamic> roleData = roleDoc.data() as Map<String, dynamic>;
    return Admin(
      userid: userDoc.id,
      firstName: userData['firstName'],
      lastName: userData['lastName'],
      email: userData['email'],
      age: userData['age'],
      phoneNumber: userData['phoneNumber'],
      profilePicture: userData['profilePicture'],
      role: userData['role'],
      gender: userData['gender'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'role': role,
      'gender': gender,
    };
  }
}

class Participant extends Usr {
  final String membershipId;
  final String membershipType;
  final String membershipExpiry;
  final List<String> enrolledClasses;
  final Map<DateTime, String> attendanceRecord;
  final int height;
  final int weight;

  Participant({
    required super.userid,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.age,
    required super.phoneNumber,
    required super.profilePicture,
    required super.role,
    required super.gender,
    required this.membershipId,
    required this.membershipType,
    required this.membershipExpiry,
    required this.enrolledClasses,
    required this.attendanceRecord,
    required this.height,
    required this.weight,
  });

  factory Participant.fromFirestore(
      DocumentSnapshot userDoc, DocumentSnapshot roleDoc) {
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    Map<String, dynamic> roleData = roleDoc.data() as Map<String, dynamic>;
    return Participant(
      userid: userDoc.id,
      firstName: userData['firstName'],
      lastName: userData['lastName'],
      email: userData['email'],
      age: userData['age'],
      phoneNumber: userData['phoneNumber'],
      profilePicture: userData['profilePicture'],
      role: userData['role'],
      gender: userData['gender'],
      membershipId: roleData['membershipId'],
      membershipType: roleData['membershipType'],
      membershipExpiry: roleData['membershipExpiry'],
      enrolledClasses: List<String>.from(roleData['enrolledClasses']),
      attendanceRecord:
          (roleData['attendanceRecord'] as Map<String, dynamic>).map(
        (k, v) => MapEntry(DateTime.parse(k), v as String),
      ),
      height: roleData['height'],
      weight: roleData['weight'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'role': role,
      'gender': gender,
      'membershipId': membershipId,
      'membershipType': membershipType,
      'membershipExpiry': membershipExpiry,
      'enrolledClasses': enrolledClasses,
      'attendanceRecord': attendanceRecord.map(
        (k, v) => MapEntry(k.toIso8601String(), v),
      ),
      'height': height,
      'weight': weight,
    };
  }
}

class Trainer extends Usr {
  final List<String> specializations;
  final List<String> certifications;
  final Map<String, List<String>> schedule;
  final List<String> assignedClasses;
  final String bio;
  final double rating;

  Trainer({
    required super.userid,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.age,
    required super.phoneNumber,
    required super.profilePicture,
    required super.role,
    required super.gender,
    required this.specializations,
    required this.certifications,
    required this.schedule,
    required this.assignedClasses,
    required this.bio,
    required this.rating,
  });

  factory Trainer.fromFirestore(
      DocumentSnapshot userDoc, DocumentSnapshot roleDoc) {
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    Map<String, dynamic> roleData = roleDoc.data() as Map<String, dynamic>;
    return Trainer(
      userid: userDoc.id,
      firstName: userData['firstName'],
      lastName: userData['lastName'],
      email: userData['email'],
      age: userData['age'],
      phoneNumber: userData['phoneNumber'],
      profilePicture: userData['profilePicture'],
      role: userData['role'],
      gender: userData['gender'],
      specializations: List<String>.from(roleData['specializations']),
      certifications: List<String>.from(roleData['certifications']),
      schedule: (roleData['schedule'] as Map<String, dynamic>).map(
        (k, v) => MapEntry(k, List<String>.from(v)),
      ),
      assignedClasses: List<String>.from(roleData['assignedClasses']),
      bio: roleData['bio'],
      rating: roleData['rating'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'role': role,
      'gender': gender,
      'specializations': specializations,
      'certifications': certifications,
      'schedule': schedule.map((k, v) => MapEntry(k, v)),
      'assignedClasses': assignedClasses,
      'bio': bio,
      'rating': rating,
    };
  }
}