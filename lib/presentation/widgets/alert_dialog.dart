// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
      backgroundColor: MyColors.myOrange2,
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: MyColors.mywhite,
            ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            'yes',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  color: MyColors.mywhite,
                ),
          ),
        ),
        TextButton(
          style:
              ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.grey)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'no',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  color: MyColors.mywhite,
                ),
          ),
        ),
      ],
    );
  }
}
