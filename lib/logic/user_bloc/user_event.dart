part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends UserEvent {
  final String email;
  final String password;

  const SignIn({required this.email, required this.password});
}

class SignInWithGoogle extends UserEvent {}

class SignOut extends UserEvent {}

class AddUserPhoneNumber extends UserEvent {
  final String phoneNumber;
  final String userID;

  const AddUserPhoneNumber({required this.phoneNumber, required this.userID});
}

class AddUserHeight extends UserEvent {
  final int height;
  final String userID;

  const AddUserHeight({required this.height, required this.userID});
}

class AddUserWeight extends UserEvent {
  final int weight;
  final String userID;

  const AddUserWeight({required this.weight, required this.userID});
}

class AddUserImage extends UserEvent {
  final String imageUrl;
  final String userID;

  const AddUserImage({required this.imageUrl, required this.userID});
}

class SignUp extends UserEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final int age;
  final String phoneNumber;
  final String gender;
  final String role;
  final String? profilePicture;
  // Additional fields for Trainer
  final List<String>? specializations;
  final List<String>? certifications;
  final Map<String, List<String>>? schedule;
  final List<String>? assignedClasses;
  final String? bio;
  final double? rating;
  // Additional fields for Participant
  final String? membershipId;
  final String? membershipType;
  final DateTime? membershipExpiry;
  final List<String>? enrolledClasses;
  final Map<DateTime, String>? attendanceRecord;
  final int? height;
  final int? weight;

  const SignUp({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.age,
    required this.gender,
    required this.role,
    this.profilePicture,
    // Additional fields for Trainer
    this.specializations,
    this.certifications,
    this.schedule,
    this.assignedClasses,
    this.bio,
    this.rating,
    // Additional fields for Participant
    this.membershipId,
    this.membershipType,
    this.membershipExpiry,
    this.enrolledClasses,
    this.attendanceRecord,
    this.height,
    this.weight,
  });
}

class GetUserInfo extends UserEvent {
  final String userID;

  const GetUserInfo({required this.userID});
}

class ResetPassword extends UserEvent {
  final String email;

  const ResetPassword({required this.email});
}
