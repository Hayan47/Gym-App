import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/equipment_model.dart';

class EquipmentCard extends StatelessWidget {
  final Equipment equipment;
  const EquipmentCard({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.mywhite,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('assets/img/Treadmill.jpg'),
            ),
            const SizedBox(height: 10),
            Text(
              'Treadmill',
              style: GoogleFonts.nunito(
                color: MyColors.myOrange,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'A machine for walking or running while staying in one place. Ideal for cardio workouts and improving endurance.',
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Location: ',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Cardio Section',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Usage: ',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Start at a slow pace and gradually increase the speed. Always use the safety key.',
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Safty Tips:',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '1- Wear proper running shoes.',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                '2- Attach the safety key to your clothing.',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                '3- Stay hydrated and take breaks as needed.',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ]),
            Text(
              'Tutorial Links:',
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'https://example.com/treadmill-usage',
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            Text(
              'https://example.com/treadmill-safety',
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
