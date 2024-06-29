import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String? jobId;
  final String title;
  final String description;
  final List<String> specializations;
  final DateTime postedDate;
  final double hourlyRate;
  final String adminPhoneNumber;

  Job({
    this.jobId,
    required this.title,
    required this.description,
    required this.postedDate,
    required this.specializations,
    required this.hourlyRate,
    required this.adminPhoneNumber,
  });

  // fromFirestore factory constructor
  factory Job.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Job(
      jobId: snapshot.id,
      title: data?['title'],
      description: data?['description'],
      postedDate: (data?['postedDate'] as Timestamp).toDate(),
      specializations: List<String>.from(data?['requirements'] ?? []),
      hourlyRate: double.parse(data!['hourlyRate'].toString()),
      adminPhoneNumber: data?['adminPhoneNumber'],
    );
  }

  // toFirestore method
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'postedDate': postedDate,
      'requirements': specializations,
      'hourlyRate': hourlyRate,
      'adminPhoneNumber': adminPhoneNumber,
    };
  }
}
