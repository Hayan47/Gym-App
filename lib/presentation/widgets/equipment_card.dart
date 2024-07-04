import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/equipment_model.dart';
import 'package:gym/presentation/widgets/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class EquipmentCard extends StatelessWidget {
  final Equipment equipment;
  const EquipmentCard({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.myGrey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: equipment.imagePath,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              equipment.name,
              style: GoogleFonts.nunito(
                color: MyColors.myOrange2,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              equipment.description,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Location: ',
                    style: GoogleFonts.nunito(
                      color: MyColors.myOrange2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: equipment.location,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
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
                      color: MyColors.myOrange2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: equipment.usageInstructions,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Safty Tips:',
              style: GoogleFonts.nunito(
                color: MyColors.myOrange2,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...List.generate(
              equipment.safetyTips.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "${index + 1}- ${equipment.safetyTips[index]}",
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                );
              },
            ),
            Text(
              'Tutorial Links:',
              style: GoogleFonts.nunito(
                color: MyColors.myOrange2,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...List.generate(
              equipment.tutorialLinks.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () async {
                      print(equipment.tutorialLinks[index]);
                      final Uri video = Uri.parse(
                        equipment.tutorialLinks[index],
                      );
                      if (await canLaunchUrl(video)) {
                        await launchUrl(video);
                      } else {
                        showToastMessage(
                          context,
                          'can\'t open link',
                          const Icon(
                            Icons.error,
                            color: MyColors.myred2,
                            size: 20,
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Video ${index + 1}",
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
