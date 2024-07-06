import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/membership_bloc/membership_bloc.dart';
import 'package:gym/presentation/widgets/create_membership.dart';
import 'package:gym/presentation/widgets/membership_card.dart';
import 'package:gym/presentation/widgets/shimmer_memberships.dart';
import 'package:gym/presentation/widgets/toast.dart';

class MymembershipScreen extends StatelessWidget {
  final Participant participant;
  const MymembershipScreen({super.key, required this.participant});

  @override
  Widget build(BuildContext context) {
    context
        .read<MembershipBloc>()
        .add(GetMemberships(userid: participant.userid));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My MemberShip',
          style: GoogleFonts.nunito(
            color: MyColors.myOrange2,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<MembershipBloc, MembershipState>(
        builder: (context, state) {
          if (state is MembershipLoaded) {
            return ListView.builder(
              itemCount: state.memberships.length + 1,
              itemBuilder: (context, index) {
                if (index == state.memberships.length) {
                  return GestureDetector(
                    onTap: () {
                      if (state.memberships.isNotEmpty) {
                        if (state.memberships.last.state == "pending") {
                          showToastMessage(
                            context,
                            "your last request is pending",
                            const Icon(
                              Icons.error,
                              color: MyColors.myred2,
                              size: 20,
                            ),
                          );
                          return;
                        } else if (state.memberships.last.state == "active") {
                          showToastMessage(
                            context,
                            "you have an active membership",
                            const Icon(
                              Icons.error,
                              color: MyColors.myred2,
                              size: 20,
                            ),
                          );
                          return;
                        }
                      }
                      showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: context.read<MembershipBloc>(),
                            child: CreateMembership(id: participant.userid),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Text(
                        "Add Membership",
                        style: GoogleFonts.nunito(
                          color: MyColors.myOrange2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                return MembershipCard(membership: state.memberships[index]);
              },
            );
          } else {
            return const MembershipsLoading();
          }
        },
      ),
    );
  }
}
