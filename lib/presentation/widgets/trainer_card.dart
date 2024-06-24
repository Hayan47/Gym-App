import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/usr_model.dart';

class TrainerCard extends StatelessWidget {
  final Trainer trainer;
  const TrainerCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: MyColors.myOrange2,
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: trainer.profilePicture!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${trainer.firstName} ${trainer.lastName}",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        trainer.phoneNumber,
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                children: List.generate(
                  trainer.specializations.length,
                  (index) {
                    return Text(
                      "${trainer.specializations[index]}, ",
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ),
              Text(
                trainer.bio,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
