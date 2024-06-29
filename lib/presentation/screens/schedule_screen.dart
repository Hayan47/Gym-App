import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/schedule_bloc/schedule_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ScheduleBloc>().add(GetHolyDays());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gym Schedule',
          style: GoogleFonts.nunito(
            color: MyColors.myOrange2,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state is ScheduleLoaded) {
                  print(state.holydays);
                  return SfDateRangePicker(
                    backgroundColor: Colors.white,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      blackoutDates: state.holydays,
                      enableSwipeSelection: false,
                      showTrailingAndLeadingDates: true,
                      weekendDays: const [5, 6],
                      viewHeaderHeight:
                          MediaQuery.sizeOf(context).height * 0.05,
                      viewHeaderStyle: DateRangePickerViewHeaderStyle(
                        backgroundColor: MyColors.myGrey.withOpacity(0.9),
                        textStyle: GoogleFonts.nunito(
                          color: MyColors.mywhite,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    //!Header Style
                    headerHeight: MediaQuery.sizeOf(context).height * 0.1,
                    headerStyle: DateRangePickerHeaderStyle(
                      backgroundColor: MyColors.myGrey.withOpacity(0.8),
                      textStyle: GoogleFonts.nunito(
                        color: MyColors.mywhite,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    todayHighlightColor: MyColors.myOrange2,
                    selectionColor: Colors.white,
                    selectionTextStyle: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    //!Day Style
                    monthCellStyle: DateRangePickerMonthCellStyle(
                      blackoutDateTextStyle: GoogleFonts.nunito(
                        color: Colors.black,
                      ),
                      blackoutDatesDecoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/holyday.jpg')),
                        shape: BoxShape.circle,
                      ),
                      textStyle: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: SizedBox(
                      width: 70,
                      height: 40,
                      child: Lottie.asset('assets/lottie/SplashyLoader.json'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
