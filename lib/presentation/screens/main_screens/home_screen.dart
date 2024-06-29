import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/equipment_bloc/equipment_bloc.dart';
import 'package:gym/presentation/widgets/equipment_card.dart';
import 'package:gym/presentation/widgets/shimmer_equipment.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'jobsscreen');
                  },
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        decoration: const BoxDecoration(
                          color: MyColors.myOrange2,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: Center(
                          child: Text(
                            'Available Jobs',
                            style: GoogleFonts.nunito(
                              color: MyColors.mywhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(12)),
                        child: Image.asset(
                          'assets/img/jobs.png',
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: MediaQuery.sizeOf(context).width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'shedulescreen');
                  },
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        decoration: const BoxDecoration(
                          color: MyColors.myOrange2,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(12)),
                        ),
                        child: Center(
                          child: Text(
                            'Gym Schedule',
                            style: GoogleFonts.nunito(
                              color: MyColors.mywhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(12)),
                        child: Image.asset(
                          'assets/img/scheduel.png',
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: MediaQuery.sizeOf(context).width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Available Equipment',
              style: GoogleFonts.nunito(
                color: MyColors.myOrange,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocBuilder<EquipmentBloc, EquipmentState>(
              builder: (context, state) {
                if (state is EquipmentLoaded) {
                  return ListView.builder(
                    itemCount: state.equipment.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index + 1 == state.equipment.length) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child:
                              EquipmentCard(equipment: state.equipment[index]),
                        );
                      } else {
                        return EquipmentCard(equipment: state.equipment[index]);
                      }
                    },
                  );
                } else {
                  return const EquipmentLoadingWidget();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
