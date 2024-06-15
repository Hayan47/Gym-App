import 'package:flutter/material.dart';
import 'package:gym/data/models/class_model.dart';
import 'package:gym/presentation/widgets/class_card.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gymClasses.length,
      itemBuilder: (context, index) {
        final gymClass = gymClasses[index];
        return const ClassCard();
      },
    );
  }
}
