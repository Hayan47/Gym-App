// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:gym/constants/my_colors.dart';

class MyAlertDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const MyAlertDialog({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: MyColors.myOrange3,
      title: Text(
        text,
        style: GoogleFonts.nunito(
          color: MyColors.mywhite,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            'yes',
            style: GoogleFonts.nunito(
              color: MyColors.mywhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          style:
              ButtonStyle(overlayColor: WidgetStateProperty.all(Colors.grey)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'no',
            style: GoogleFonts.nunito(
              color: MyColors.mywhite,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
