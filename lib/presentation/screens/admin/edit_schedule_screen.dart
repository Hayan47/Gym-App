import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/schedule_bloc/schedule_bloc.dart';
import 'package:gym/presentation/widgets/toast.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditScheduleScreen extends StatelessWidget {
  const EditScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ScheduleBloc>().add(GetHolyDays());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Schedule',
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
            child: BlocConsumer<ScheduleBloc, ScheduleState>(
              listener: (context, state) {
                if (state is ScheduleAdded) {
                  showToastMessage(
                    context,
                    state.message,
                    const Icon(
                      Icons.done,
                      color: Colors.green,
                      size: 20,
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is ScheduleError) {
                  showToastMessage(
                    context,
                    state.message,
                    const Icon(
                      Icons.error,
                      color: MyColors.myred2,
                      size: 20,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ScheduleLoaded) {
                  return SfDateRangePicker(
                    showActionButtons: true,
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onSubmit: (p0) {
                      if (p0 is List<DateTime>) {
                        context
                            .read<ScheduleBloc>()
                            .add(AddHolyDays(holydays: p0));
                      }
                    },
                    // onSelectionChanged:
                    //     (DateRangePickerSelectionChangedArgs args) {
                    //   // if (args.value is PickerDateRange) {
                    //   //   PickerDateRange pickerDateRange = args.value;
                    //   //   context
                    //   //       .read<ReservationBloc>()
                    //   //       .add(PickRange(pickerDateRange: pickerDateRange));
                    //   // }
                    // },
                    //!mode
                    selectionMode: DateRangePickerSelectionMode.multiple,
                    //!past days
                    enablePastDates: false,
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
                    selectionColor: MyColors.myOrange3,
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
