import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/membership_model.dart';
import 'package:intl/intl.dart';

class MembershipCard extends StatelessWidget {
  final Membership membership;
  const MembershipCard({super.key, required this.membership});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: membership.state == "pending"
            ? MyColors.myOrange3
            : membership.state == "active" || membership.state == "paid"
                ? Colors.green
                : MyColors.myred2,
        child: ListTile(
          title: Row(
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
          subtitle: Row(
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
        ),
      ),
    );
  }
}
