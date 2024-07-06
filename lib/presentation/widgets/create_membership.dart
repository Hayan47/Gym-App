// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/data/models/membership_model.dart';
import 'package:gym/logic/membership_bloc/membership_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/presentation/widgets/toast.dart';
import 'package:lottie/lottie.dart';

class CreateMembership extends StatefulWidget {
  final String id;
  const CreateMembership({super.key, required this.id});

  @override
  State<CreateMembership> createState() => _CreateMembershipState();
}

class _CreateMembershipState extends State<CreateMembership> {
  DateTime? startDate;

  DateTime? endDate;

  int price = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MembershipBloc, MembershipState>(
      listener: (context, state) {
        if (state is MembershipAdded) {
          Navigator.pop(context);
          showToastMessage(
            context,
            'membership has been added',
            const Icon(
              Icons.done,
              color: Colors.green,
              size: 18,
            ),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: MyColors.myGrey,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          content: SizedBox(
            height: 125,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    'Add Membership',
                    style: GoogleFonts.nunito(
                      color: MyColors.mywhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () async {
                        startDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now(),
                        );
                        if (startDate != null && endDate != null) {
                          price =
                              (endDate!.difference(startDate!).inDays + 1) * 5;
                        }
                        setState(() {});
                      },
                      style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                          backgroundColor:
                              WidgetStateProperty.all(MyColors.myOrange2)),
                      child: Text(
                        startDate != null
                            ? "${startDate!.year}-${startDate!.month}-${startDate!.day}"
                            : "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                        style: GoogleFonts.nunito(
                          color: MyColors.mywhite,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/icons/arrow_right.png',
                      color: MyColors.myOrange2,
                      width: 30,
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () async {
                        endDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2100),
                          initialDate: DateTime.now(),
                        );
                        if (startDate != null && endDate != null) {
                          price =
                              (endDate!.difference(startDate!).inDays + 1) * 5;
                        }
                        setState(() {});
                      },
                      style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                          backgroundColor:
                              WidgetStateProperty.all(MyColors.myOrange2)),
                      child: Text(
                        endDate != null
                            ? "${endDate!.year}-${endDate!.month}-${endDate!.day}"
                            : "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
                        style: GoogleFonts.nunito(
                          color: MyColors.mywhite,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      endDate != null && startDate != null
                          ? "days: ${endDate!.difference(startDate!).inDays + 1}"
                          : "",
                      style: GoogleFonts.nunito(
                        color: MyColors.mywhite,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      endDate != null && startDate != null
                          ? "price: $price \$"
                          : "",
                      style: GoogleFonts.nunito(
                        color: MyColors.mywhite,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5, bottom: 15),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor:
                        WidgetStateProperty.all(MyColors.myOrange3)),
                child: Text(
                  "cancel",
                  style: GoogleFonts.nunito(
                    color: MyColors.mywhite,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            BlocConsumer<MembershipBloc, MembershipState>(
              listener: (context, state) {
                if (state is MembershipAdded) {
                  showToastMessage(
                    context,
                    'Membership request sent sucessfully',
                    const Icon(
                      Icons.done,
                      color: Colors.green,
                      size: 20,
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is MembershipError) {
                  showToastMessage(
                    context,
                    state.message,
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 20,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is MembershipLoading) {
                  return SizedBox(
                    width: 50,
                    child: Lottie.asset('assets/lottie/SplashyLoader.json'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5, bottom: 15),
                    child: TextButton(
                      onPressed: () {
                        if (startDate != null && endDate != null) {
                          if (endDate!.difference(startDate!).inDays + 1 >= 7) {
                            context.read<MembershipBloc>().add(
                                  AddMembership(
                                    userid: widget.id,
                                    membership: Membership(
                                      startDate: startDate!,
                                      endDate: endDate!,
                                      price: price,
                                      state: "pending",
                                      createdAt: DateTime.now(),
                                    ),
                                  ),
                                );
                          } else {
                            showToastMessage(
                              context,
                              'at least 7 days membership required',
                              const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 20,
                              ),
                            );
                          }
                        } else {
                          showToastMessage(
                            context,
                            'choose dates first',
                            const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 20,
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                          backgroundColor:
                              WidgetStateProperty.all(MyColors.myOrange2)),
                      child: Text(
                        "submit",
                        style: GoogleFonts.nunito(
                          color: MyColors.mywhite,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
