import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/usr_model.dart';

class TrainerDetailsScreen extends StatelessWidget {
  final Trainer trainer;
  const TrainerDetailsScreen({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            trainer.bio,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                'Specializations : ',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                    trainer.specializations.length,
                    (index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColors.myOrange2,
                        ),
                        height: 25,
                        child: Center(
                          child: Text(
                            trainer.specializations[index],
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          //! Assigned Classes
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, 'assignedclassesscreen',
                    arguments: trainer.userid);
              },
              leading: const Icon(
                FontAwesomeIcons.dumbbell,
                color: MyColors.myOrange2,
              ),
              title: Text(
                'Assigned Classes',
                style: GoogleFonts.nunito(
                  color: MyColors.myOrange2,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: MyColors.myOrange2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
