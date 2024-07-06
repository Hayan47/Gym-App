part of 'membership_bloc.dart';

sealed class MembershipEvent extends Equatable {
  const MembershipEvent();

  @override
  List<Object> get props => [];
}

class GetMemberships extends MembershipEvent {
  final String userid;

  const GetMemberships({required this.userid});
}

class AddMembership extends MembershipEvent {
  final String userid;
  final Membership membership;

  const AddMembership({required this.userid, required this.membership});
}

class GetPendingMemberships extends MembershipEvent {}

class UpdateMembershipState extends MembershipEvent {
  final String userid;
  final String membershipid;
  final String newState;

  const UpdateMembershipState({
    required this.userid,
    required this.membershipid,
    required this.newState,
  });
}
