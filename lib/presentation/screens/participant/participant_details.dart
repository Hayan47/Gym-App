import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/widgets/add_height.dart';
import 'package:gym/presentation/widgets/add_weight.dart';

class ParticipantDetails extends StatelessWidget {
  final Participant participant;
  const ParticipantDetails({super.key, required this.participant});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //! Health Information
        Text(
          'Helath Inforamtion',
          style: GoogleFonts.nunito(
            color: MyColors.myOrange2,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.3,
              height: MediaQuery.sizeOf(context).width * 0.25,
              decoration: BoxDecoration(
                color: MyColors.myOrange2,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Hieght',
                    style: GoogleFonts.nunito(
                      color: MyColors.mywhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<UserBloc>(context),
                            child: AddHeight(id: participant.userid),
                          );
                        },
                      );
                    },
                    child: participant.height == 0
                        ? Text(
                            'Add',
                            style: GoogleFonts.nunito(
                              color: MyColors.mywhite,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            participant.height.toString(),
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
            Container(
              width: MediaQuery.sizeOf(context).width * 0.3,
              height: MediaQuery.sizeOf(context).width * 0.25,
              decoration: BoxDecoration(
                color: MyColors.myOrange2,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Wieght',
                    style: GoogleFonts.nunito(
                      color: MyColors.mywhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<UserBloc>(context),
                            child: AddWeight(id: participant.userid),
                          );
                        },
                      );
                    },
                    child: participant.weight == 0
                        ? Text(
                            'Add',
                            style: GoogleFonts.nunito(
                              color: MyColors.mywhite,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            participant.weight.toString(),
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
        //! Enrolled Classes
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'enrolledclassesscreen',
                  arguments: participant.userid);
            },
            leading: const Icon(
              FontAwesomeIcons.dumbbell,
              color: MyColors.myOrange2,
            ),
            title: Text(
              'Enrolled Classes',
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
        //! My Membership
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'mymembershipscreen',
                  arguments: participant);
            },
            leading: const Icon(
              Icons.library_books_rounded,
              color: MyColors.myOrange2,
            ),
            title: Text(
              'My Membership',
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
    );
  }
}
