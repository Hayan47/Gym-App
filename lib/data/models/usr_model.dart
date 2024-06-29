import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Usr extends Equatable {
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

  @override
  List<Object?> get props => [
        userid,
        firstName,
        lastName,
        email,
        phoneNumber,
        profilePicture,
        age,
        gender,
        role,
      ];
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

  @override
  List<Object?> get props => [
        userid,
        firstName,
        lastName,
        email,
        phoneNumber,
        profilePicture,
        age,
        gender,
        role,
      ];
}

class Participant extends Usr {
  final List<String> enrolledClasses;
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
    required this.enrolledClasses,
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
      enrolledClasses: List<String>.from(roleData['enrolledClasses']),
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
      'enrolledClasses': enrolledClasses,
      'height': height,
      'weight': weight,
    };
  }

  @override
  List<Object?> get props => [
        userid,
        firstName,
        lastName,
        email,
        phoneNumber,
        profilePicture,
        age,
        gender,
        role,
        enrolledClasses,
        height,
        weight,
      ];
}

class Trainer extends Usr {
  final List<String> specializations;
  final List<String> assignedClasses;
  final String bio;
  final double rating;
  final int numberOfRatings;

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
    required this.assignedClasses,
    required this.bio,
    required this.rating,
    required this.numberOfRatings,
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
      assignedClasses: List<String>.from(roleData['assignedClasses']),
      bio: roleData['bio'],
      rating: double.parse(roleData['rating'].toString()),
      numberOfRatings: roleData['numberOfRatings'],
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
      'assignedClasses': assignedClasses,
      'bio': bio,
      'rating': rating,
      'numberOfRatings': numberOfRatings,
    };
  }

  @override
  List<Object?> get props => [
        userid,
        firstName,
        lastName,
        email,
        phoneNumber,
        profilePicture,
        age,
        gender,
        role,
        specializations,
        assignedClasses,
        bio,
        rating,
        numberOfRatings,
      ];
}
