import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/membership_model.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/membership_bloc/membership_bloc.dart';
import 'package:intl/intl.dart';

class MembershipRequestCard extends StatelessWidget {
  final Map<String, dynamic> pendingMembership;
  const MembershipRequestCard({super.key, required this.pendingMembership});

  @override
  Widget build(BuildContext context) {
    Participant user = pendingMembership['user'];
    Membership membership = pendingMembership['membership'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: MyColors.myGrey,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: (user.profilePicture != null)
                        ? user.profilePicture!
                        : 'https://i.imgur.com/sWmIhUZ.png',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
                Text(
                  "Participant: ${user.firstName} ${user.lastName}",
                  style: GoogleFonts.nunito(
                    color: MyColors.mywhite,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  DateFormat('MMM d, yyyy').format(membership.startDate),
                  style: GoogleFonts.nunito(
                    color: MyColors.mywhite,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'assets/icons/arrow_right.png',
                  color: MyColors.myOrange2,
                  width: 30,
                  height: 30,
                ),
                Text(
                  DateFormat('MMM d, yyyy').format(membership.endDate),
                  style: GoogleFonts.nunito(
                    color: MyColors.mywhite,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'price: ${membership.price} \$',
                  style: GoogleFonts.nunito(
                    color: MyColors.mywhite,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "state: ${membership.state}",
                  style: GoogleFonts.nunito(
                    color: MyColors.mywhite,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<MembershipBloc>().add(
                            UpdateMembershipState(
                              userid: user.userid,
                              membershipid: membership.membershipid!,
                              newState: "rejected",
                            ),
                          );
                    },
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        fixedSize: WidgetStateProperty.all(const Size(120, 30)),
                        backgroundColor:
                            WidgetStateProperty.all(MyColors.myOrange3)),
                    child: Text(
                      'Reject',
                      style: GoogleFonts.nunito(
                        color: MyColors.mywhite,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<MembershipBloc>().add(
                            UpdateMembershipState(
                              userid: user.userid,
                              membershipid: membership.membershipid!,
                              newState: "paid",
                            ),
                          );
                    },
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        fixedSize: WidgetStateProperty.all(const Size(120, 30)),
                        backgroundColor:
                            WidgetStateProperty.all(MyColors.myOrange2)),
                    child: Text(
                      'Activate',
                      style: GoogleFonts.nunito(
                        color: MyColors.mywhite,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
