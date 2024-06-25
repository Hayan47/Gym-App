import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/auth_cubit/auth_cubit.dart';
import 'package:gym/logic/trainers_bloc/trainers_bloc.dart';
import 'package:gym/presentation/widgets/toast.dart';

class RateTrainer extends StatefulWidget {
  final String trainerId;
  const RateTrainer({super.key, required this.trainerId});

  @override
  State<RateTrainer> createState() => _RateTrainerState();
}

class _RateTrainerState extends State<RateTrainer> {
  double rating = 1.0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<TrainersBloc, TrainersState>(
      listener: (context, state) {
        if (state is TrainerRated) {
          Navigator.pop(context);
          showToastMessage(
            context,
            state.message,
            const Icon(
              Icons.done,
              color: Colors.green,
              size: 20,
            ),
          );
        } else if (state is TrainersError) {
          Navigator.pop(context);
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
      child: AlertDialog(
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
                  'Rate Trainer',
                  style: GoogleFonts.nunito(
                    color: MyColors.mywhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RatingBar(
                allowHalfRating: true,
                minRating: 1,
                maxRating: 5,
                initialRating: 1,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  half: const Icon(
                    Icons.star_half,
                    color: Colors.yellow,
                  ),
                  empty: const Icon(
                    Icons.star,
                    color: Colors.white70,
                  ),
                ),
                onRatingUpdate: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, bottom: 15),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () async {
                    if (state is NotAuthenticated) {
                      showToastMessage(
                        context,
                        'you need to login first',
                        const Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 20,
                        ),
                      );
                    } else if (state is Authenticated) {
                      context.read<TrainersBloc>().add(
                            RateTrainerEvent(
                                rating: rating,
                                trainerId: widget.trainerId,
                                userId: state.user.uid),
                          );
                    }
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
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
