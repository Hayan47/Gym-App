// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/presentation/widgets/toast.dart';

class AddHeight extends StatelessWidget {
  final String id;
  AddHeight({super.key, required this.id});

  final _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserInitial) {
          Navigator.pop(context);
          showToastMessage(
            context,
            'Height has been added',
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
          backgroundColor: MyColors.myOrange3,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          content: SizedBox(
            height: 120,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    'Add Your Height',
                    style: GoogleFonts.nunito(
                      color: MyColors.mywhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: MyColors.mywhite,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: MyColors.myGrey,
                          width: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.nunito(
                          color: MyColors.myOrange2,
                          fontSize: 14,
                        ),
                        controller: _heightController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null) {
                            return 'Enter a valid Height';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Height...',
                          hintStyle: GoogleFonts.nunito(
                            color: MyColors.myOrange2,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 15),
              child: GestureDetector(
                onTap: () async {
                  context.read<UserBloc>().add(
                        AddUserHeight(
                            height: int.parse(_heightController.text),
                            userID: id),
                      );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.mywhite,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: MyColors.myGrey,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'submit',
                      style: GoogleFonts.nunito(
                        color: MyColors.myOrange2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
