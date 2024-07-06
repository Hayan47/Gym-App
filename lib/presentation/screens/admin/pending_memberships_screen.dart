import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/membership_bloc/membership_bloc.dart';
import 'package:gym/presentation/widgets/membership_request_card.dart';
import 'package:gym/presentation/widgets/shimmer_memberships.dart';
import 'package:gym/presentation/widgets/toast.dart';

class PendingMembershipsScreen extends StatelessWidget {
  const PendingMembershipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MembershipBloc>().add(GetPendingMemberships());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pending MemberShips',
          style: GoogleFonts.nunito(
            color: MyColors.myOrange2,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<MembershipBloc, MembershipState>(
        listener: (context, state) {
          if (state is MembershipUpdated) {
            showToastMessage(
              context,
              state.message,
              const Icon(
                Icons.done,
                color: Colors.green,
                size: 20,
              ),
            );
            context.read<MembershipBloc>().add(GetPendingMemberships());
          } else if (state is MembershipError) {
            showToastMessage(
              context,
              state.message,
              const Icon(
                Icons.error,
                color: MyColors.myred2,
                size: 20,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PendingMembershipLoaded) {
            return ListView.builder(
              itemCount: state.pendingMemberships.length,
              itemBuilder: (context, index) {
                return MembershipRequestCard(
                    pendingMembership: state.pendingMemberships[index]);
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
