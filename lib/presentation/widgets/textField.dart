// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/my_colors.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction actionType;

  const MyTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.inputType,
    required this.actionType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 44,
        // width: MediaQuery.sizeOf(context).width * 0.4,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: MyColors.mywhite,
            width: 0.4,
          ),
        ),
        child: TextField(
          maxLines: 1,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            color: MyColors.myGrey,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            //!hint style
            hintStyle: GoogleFonts.nunito(
              color: MyColors.myGrey.withOpacity(0.5),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            //!hint
            hintText: hint,
            floatingLabelStyle: const TextStyle(color: MyColors.myBlue2),
            labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: MyColors.mywhite,
                ),
            floatingLabelAlignment: FloatingLabelAlignment.start,
          ),
          cursorHeight: 18,
          keyboardType: inputType,
          textInputAction: actionType,
        ),
      ),
    );
  }
}
