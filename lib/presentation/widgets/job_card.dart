import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/job_model.dart';
import 'package:gym/presentation/widgets/toast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: MyColors.myGrey,
        child: ListTile(
          title: Row(
            children: [
              const Icon(
                Icons.work_rounded,
                color: MyColors.myOrange2,
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                job.title,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: MyColors.myOrange2,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.description,
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 5),
              Wrap(
                children: List.generate(
                  job.specializations.length,
                  (index) {
                    return Text(
                      "${job.specializations[index]}, ",
                      style: GoogleFonts.nunito(
                        color: MyColors.myOrange3,
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () async {
                  final Uri phone = Uri(
                    scheme: 'tel',
                    path: job.adminPhoneNumber,
                  );
                  if (await canLaunchUrl(phone)) {
                    await launchUrl(phone);
                  } else {
                    showToastMessage(
                      context,
                      'can\'t open phone number',
                      const Icon(
                        Icons.error,
                        color: MyColors.myred2,
                        size: 20,
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    fixedSize: WidgetStateProperty.all(const Size(140, 30)),
                    backgroundColor:
                        WidgetStateProperty.all(MyColors.myOrange2)),
                child: Text(
                  'Contact Us',
                  style: GoogleFonts.nunito(
                    color: MyColors.mywhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.clock,
                    color: Colors.white70,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat('EEE, MMM d, yyyy, hh:mm a')
                        .format(job.postedDate),
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
