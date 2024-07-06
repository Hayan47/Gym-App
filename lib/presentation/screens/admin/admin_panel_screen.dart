import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/admin_bloc/admin_bloc.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/widgets/alert_dialog.dart';

class AdminPanelScreen extends StatelessWidget {
  final Admin admin;
  const AdminPanelScreen({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    context.read<AdminBloc>().add(GetUsersCount());
    return ListView(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.3,
              height: MediaQuery.sizeOf(context).width * 0.25,
              decoration: BoxDecoration(
                color: MyColors.myOrange3,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Participnats',
                    style: GoogleFonts.nunito(
                      color: MyColors.mywhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  BlocBuilder<AdminBloc, AdminState>(
                    builder: (context, state) {
                      if (state is AdminLoaded) {
                        return Text(
                          state.participantsCount.toString(),
                          style: GoogleFonts.nunito(
                            color: MyColors.mywhite,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.3,
              height: MediaQuery.sizeOf(context).width * 0.25,
              decoration: BoxDecoration(
                color: MyColors.myOrange3,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Trainers',
                    style: GoogleFonts.nunito(
                      color: MyColors.mywhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  BlocBuilder<AdminBloc, AdminState>(
                    builder: (context, state) {
                      if (state is AdminLoaded) {
                        return Text(
                          state.trainersCount.toString(),
                          style: GoogleFonts.nunito(
                            color: MyColors.mywhite,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        //! add Equipment
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'addequipment');
            },
            leading: const Icon(
              FontAwesomeIcons.dumbbell,
              color: MyColors.myOrange2,
            ),
            title: Text(
              'Add Equipment',
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
        //! add Job
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'createjobscreen', arguments: admin);
            },
            leading: const Icon(
              Icons.work_rounded,
              color: MyColors.myOrange2,
            ),
            title: Text(
              'Add Job Opportunity',
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
        //! pending classes
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'pendingclassesscreen');
            },
            leading: const Icon(
              FontAwesomeIcons.personRunning,
              color: MyColors.myOrange2,
            ),
            title: Text(
              'Pending Classes',
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
        //! pending memberships
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'pendingmembershipsscreen');
            },
            leading: const Icon(
              Icons.library_books_rounded,
              color: MyColors.myOrange2,
            ),
            title: Text(
              'Pending Memberships',
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
        //! edit schedule
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'editschedule');
            },
            leading: const Icon(
              Icons.schedule,
              color: MyColors.myOrange2,
            ),
            title: Text(
              'Edit Schedule',
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
        //! sign out
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return BlocProvider.value(
                    value: context.read<UserBloc>(),
                    child: MyAlertDialog(
                        onPressed: () {
                          context.read<UserBloc>().add(SignOut());
                          Navigator.pop(context);
                        },
                        text: 'Are you sure you want to sign out?'),
                  );
                },
              );
            },
            style: ButtonStyle(
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
                fixedSize: WidgetStateProperty.all(const Size(160, 40)),
                backgroundColor: WidgetStateProperty.all(MyColors.myOrange2)),
            child: Text(
              'Sign out',
              style: GoogleFonts.nunito(
                color: MyColors.mywhite,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
