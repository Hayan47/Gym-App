import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/data/models/membership_model.dart';
import 'package:gym/data/models/usr_model.dart';

class MembershipService {
  final _store = FirebaseFirestore.instance;

  //? add a membership
  Future<void> addMembership(Membership membership, String userid) async {
    await _store
        .collection('users')
        .doc(userid)
        .collection('memberships')
        .withConverter<Membership>(
          fromFirestore: Membership.fromFirestore,
          toFirestore: (membership, options) => membership.toFirestore(),
        )
        .add(membership);
  }

  //? get memberships
  Future<List<Membership>> getMemberships(String userid) async {
    List<Membership> memberships = [];

    var snapshot = await _store
        .collection('users')
        .doc(userid)
        .collection('memberships')
        .withConverter<Membership>(
          fromFirestore: Membership.fromFirestore,
          toFirestore: (membership, options) => membership.toFirestore(),
        )
        .orderBy('createdAt', descending: true)
        .get();

    for (var doc in snapshot.docs) {
      var membership = doc.data();
      checkAndUpdateState(userid, membership);
      memberships.add(membership);
    }
    return memberships;
  }

  //? Method to check and update state
  Future<void> checkAndUpdateState(String userId, Membership membership) async {
    if (membership.endDate.isBefore(DateTime.now())) {
      await _store
          .collection('users')
          .doc(userId)
          .collection('memberships')
          .doc(membership.membershipid)
          .update({'state': 'expired'});
    } else if (membership.startDate.isBefore(DateTime.now()) &&
        membership.state == "paid") {
      await _store
          .collection('users')
          .doc(userId)
          .collection('memberships')
          .doc(membership.membershipid)
          .update({'state': 'active'});
    }
  }

  //?get pending memberships
  Future<List<Map<String, dynamic>>> getPendingMemberships() async {
    List<Map<String, dynamic>> pendingMemberships = [];

    // Get all user documents
    var snapshot = await _store
        .collection('users')
        .where('role', isEqualTo: 'participant')
        .get();

    // Iterate through each user document
    for (var userDoc in snapshot.docs) {
      // Get the user data
      var userData = userDoc.data();
      final role = userData['role'];
      final roleDoc =
          await userDoc.reference.collection('details').doc(role).get();

      Participant user = Participant.fromFirestore(userDoc, roleDoc);

      // Get the memberships subcollection
      var snapshot = await userDoc.reference
          .collection('memberships')
          .where('state', isEqualTo: 'pending')
          .withConverter<Membership>(
            fromFirestore: Membership.fromFirestore,
            toFirestore: (membership, options) => membership.toFirestore(),
          )
          .orderBy('createdAt', descending: true)
          .get();

      // Iterate through each pending membership
      for (var membershipDoc in snapshot.docs) {
        var membership = membershipDoc.data();

        // Add the membership data along with the user data to the list
        pendingMemberships.add(
          {
            'user': user,
            'membership': membership,
          },
        );
      }
    }
    return pendingMemberships;
  }

  //?update state
  Future<void> updateMembershipState(
      String userId, String membershipId, String newState) async {
    await _store
        .collection('users')
        .doc(userId)
        .collection('memberships')
        .doc(membershipId)
        .update({'state': newState});
  }
}
