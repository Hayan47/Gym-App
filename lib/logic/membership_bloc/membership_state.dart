part of 'membership_bloc.dart';

sealed class MembershipState extends Equatable {
  const MembershipState();

  @override
  List<Object> get props => [];
}

final class MembershipInitial extends MembershipState {}

class MembershipLoading extends MembershipState {}

class MembershipLoaded extends MembershipState {
  final List<Membership> memberships;

  const MembershipLoaded({required this.memberships});
}

class PendingMembershipLoaded extends MembershipState {
  final List<Map<String, dynamic>> pendingMemberships;

  const PendingMembershipLoaded({required this.pendingMemberships});
}

class MembershipError extends MembershipState {
  final String message;

  const MembershipError({required this.message});
}

class MembershipAdded extends MembershipState {
  final String message;

  const MembershipAdded({required this.message});
}

class MembershipUpdated extends MembershipState {
  final String message;

  const MembershipUpdated({required this.message});
}
