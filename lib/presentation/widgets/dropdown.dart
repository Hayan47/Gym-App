import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/my_colors.dart';

class MyDropdown extends StatelessWidget {
  final double? width;
  final String label;
  final Object dropdownValue;
  final List<DropdownMenuItem<Object>> items;
  final ValueChanged onChanged;
  final String icon;
  const MyDropdown({
    super.key,
    this.width,
    required this.label,
    required this.dropdownValue,
    required this.items,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                // color: // MyColors.myBlue,
                //     icon == 'assets/icons/age.png' ? null : MyColors.myBlue,
                width: 25,
                height: 25,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.nunito(
                  color: MyColors.myOrange2,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // const SizedBox(width: 25),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              style: GoogleFonts.nunito(
                color: MyColors.myOrange2,
                fontSize: 14,
              ),
              value: dropdownValue,
              items: items,
              onChanged: onChanged,

              //button style
              buttonStyleData: ButtonStyleData(
                height: 40,
                width: MediaQuery.sizeOf(context).width * 0.4,
                // elevation: 2,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: MyColors.myOrange2,
                  ),
                ),
              ),

              //icon style
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: MyColors.myOrange2,
                  size: 15,
                ),
              ),

              //dropdown style
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                offset: const Offset(5, -3),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: WidgetStateProperty.all(6),
                  thumbColor: WidgetStateProperty.all(MyColors.myOrange2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
