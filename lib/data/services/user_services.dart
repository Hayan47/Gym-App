import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/usr_model.dart';

class UserServices {
  final auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  //? sign in
  Future<UserCredential> signIn(String email, String password) async {
    final cred =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return cred;
  }

  signOut() async {
    auth.signOut();
  }

  //? sign up
  Future<UserCredential> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required int age,
    required String role,
    required String gender,
    String? profilePicture,
    // Additional fields for Trainer
    List<String>? specializations,
    List<String>? assignedClasses,
    String? bio,
    double? rating,
    int? numberOfRatings,
    // Additional fields for Participant
    List<String>? enrolledClasses,
    int? height,
    int? weight,
  }) async {
    // Create user in Firebase Authentication
    UserCredential cred =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Add user details to Firestore
    await addUserDetails(
      id: cred.user!.uid,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      email: email,
      age: age,
      role: role,
      profilePicture: profilePicture,
      gender: gender,
      specializations: specializations,
      assignedClasses: assignedClasses,
      bio: bio,
      rating: rating,
      numberOfRatings: numberOfRatings,
      enrolledClasses: enrolledClasses,
      height: height,
      weight: weight,
    );

    return cred;
  }

//? add user details
  Future<void> addUserDetails({
    required String id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required int age,
    required String role,
    required String gender,
    String? profilePicture,
    // Additional fields for Trainer
    List<String>? specializations,
    List<String>? assignedClasses,
    String? bio,
    double? rating,
    int? numberOfRatings,
    // Additional fields for Participant
    List<String>? enrolledClasses,
    int? height,
    int? weight,
  }) async {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(id);

    // Basic user data
    final userData = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'phoneNumber': phoneNumber,
      if (profilePicture != null) 'profilePicture': profilePicture,
      'role': role,
      'gender': gender,
    };

    // Role-specific data
    final roleData = <String, dynamic>{};

    if (role == 'trainer') {
      roleData.addAll({
        'specializations': specializations ?? [],
        'assignedClasses': assignedClasses ?? [],
        'bio': bio ?? '',
        'rating': rating ?? 0.0,
        'numberOfRatings': numberOfRatings ?? 0,
      });
    } else if (role == 'participant') {
      roleData.addAll({
        'enrolledClasses': enrolledClasses ?? [],
        'height': height ?? 0,
        'weight': weight ?? 0,
      });
    }

    // Store user data
    await userDocRef.set(userData);

    // Store role-specific data
    if (roleData.isNotEmpty) {
      await userDocRef.collection('details').doc(role).set(roleData);
    }
  }

  //? add img
  Future addImage(String url, String id) async {
    await _store.collection('users').doc(id).update({
      'profilePicture': url,
    });
  }

  //? get user info
  Future<Usr?> getUserInfo(String userId) async {
    final userDocRef = _store.collection('users').doc(userId);
    final userDoc = await userDocRef.get();

    final userData = userDoc.data()!;
    final role = userData['role'];
    final roleDoc = await userDocRef.collection('details').doc(role).get();

    if (role == 'admin') {
      return Admin.fromFirestore(userDoc);
    } else if (role == 'trainer') {
      return Trainer.fromFirestore(userDoc, roleDoc);
    } else if (role == 'participant') {
      return Participant.fromFirestore(userDoc, roleDoc);
    } else {
      return null; // Unknown role
    }
  }

  //? reset password
  Future resetPassword(String email) async {
    auth.sendPasswordResetEmail(email: email);
  }

  //? add phone number
  Future addPhoneNumber(String phoneNumber, String userID) async {
    await _store.collection('users').doc(userID).update({
      'phoneNumber': phoneNumber,
    });
  }

  //? add height
  Future addHeight(int height, String userID) async {
    await _store
        .collection('users')
        .doc(userID)
        .collection('details')
        .doc('participant')
        .update({
      'height': height,
    });
  }

  //? add weight
  Future addWeight(int weight, String userID) async {
    await _store
        .collection('users')
        .doc(userID)
        .collection('details')
        .doc('participant')
        .update({
      'weight': weight,
    });
  }
}
