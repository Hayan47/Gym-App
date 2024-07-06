import 'package:cloud_firestore/cloud_firestore.dart';

class Membership {
  final String? membershipid;
  final DateTime startDate;
  final DateTime endDate;
  final int price;
  final String state; // 'pending', 'paid', 'active', 'expired', 'rejected'
  final DateTime createdAt;

  Membership({
    this.membershipid,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.state,
    required this.createdAt,
  });

  factory Membership.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data();
    return Membership(
        membershipid: doc.id,
        startDate: (data?['startDate'] as Timestamp).toDate(),
        endDate: (data?['endDate'] as Timestamp).toDate(),
        price: data?['price'] ?? 0,
        state: data?['state'] ?? 'pending',
        createdAt: (data?['createdAt'] as Timestamp).toDate());
  }

  Map<String, dynamic> toFirestore() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'price': price,
      'state': state,
      'createdAt': createdAt,
    };
  }
}
