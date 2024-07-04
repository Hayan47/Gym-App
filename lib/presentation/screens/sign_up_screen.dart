import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/presentation/screens/participant/participant_signup.dart';
import 'package:gym/presentation/screens/trainer/trainer_signup.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //?app bar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: MyColors.myOrange2),
          title: const Padding(
            padding: EdgeInsets.only(right: 50),
            child: TabBar(
              dividerColor: MyColors.myGrey,
              labelColor: MyColors.myOrange2,
              indicatorColor: MyColors.myOrange2,
              unselectedLabelColor: MyColors.myGrey,
              tabs: [
                Tab(text: 'Participant'),
                Tab(text: 'Trainer'),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Column(
              children: [
                Text(
                  //!first message
                  'Join Us',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  //!second message
                  'Sign up and explore',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const Expanded(
              child: TabBarView(children: [
                ParticipantSignup(),
                TrainerSignup(),
              ]),
            ),
            //!Last Message
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Any proplem?',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  child: Text(
                    'Contact Us',
                    style: GoogleFonts.nunito(
                      color: MyColors.myOrange2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
