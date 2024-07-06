import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/data/models/membership_model.dart';
import 'package:gym/data/services/membership_service.dart';
part 'membership_event.dart';
part 'membership_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  final membershipService = MembershipService();

  List<Membership> memberships = [];

  List<Map<String, dynamic>> pendingMemberships = [];

  MembershipBloc() : super(MembershipInitial()) {
    on<GetMemberships>(
      (event, emit) async {
        try {
          emit(MembershipLoading());
          print(state);
          memberships = await membershipService.getMemberships(event.userid);
          emit(MembershipLoaded(memberships: memberships));
          print(state);
        } catch (e) {
          emit(const MembershipError(message: "error getting memberships"));
          print(state);
        }
      },
    );

    on<AddMembership>(
      (event, emit) async {
        try {
          emit(MembershipLoading());
          print(state);
          await membershipService.addMembership(event.membership, event.userid);
          emit(const MembershipAdded(
              message: "membership created successfully"));
          print(state);
        } catch (e) {
          emit(const MembershipError(message: "error creating membership"));
          print(state);
        }
      },
    );

    on<GetPendingMemberships>(
      (event, emit) async {
        try {
          emit(MembershipLoading());
          print(state);
          pendingMemberships = await membershipService.getPendingMemberships();
          emit(PendingMembershipLoaded(pendingMemberships: pendingMemberships));
          print(state);
        } catch (e) {
          emit(const MembershipError(message: "error getting memberships"));
          print(state);
          print(e);
        }
      },
    );

    on<UpdateMembershipState>(
      (event, emit) async {
        try {
          emit(MembershipLoading());
          print(state);
          membershipService.updateMembershipState(
              event.userid, event.membershipid, event.newState);
          if (event.newState == "paid") {
            emit(const MembershipUpdated(
                message: "membership activated successfully"));
          } else {
            emit(const MembershipUpdated(message: "membership rejected"));
          }
          print(state);
        } catch (e) {
          emit(const MembershipError(message: "error updating membership"));
          print(state);
        }
      },
    );
  }
}
