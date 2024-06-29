import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/trainers_bloc/trainers_bloc.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/widgets/rate_trainer.dart';
import 'package:gym/presentation/widgets/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class TrainerCard extends StatelessWidget {
  final Trainer trainer;
  const TrainerCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: MyColors.myOrange2,
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: trainer.profilePicture!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Column(
                    children: [
                      Text(
                        "${trainer.firstName} ${trainer.lastName}",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final userState =
                              BlocProvider.of<UserBloc>(context).state;
                          if (userState is UserLoaded) {
                            if (userState.userInfo is Participant) {
                              showDialog(
                                context: context,
                                barrierColor: Colors.transparent,
                                builder: (_) {
                                  return BlocProvider.value(
                                    value:
                                        BlocProvider.of<TrainersBloc>(context),
                                    child:
                                        RateTrainer(trainerId: trainer.userid),
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Row(
                          children: [
                            RatingBar(
                              ignoreGestures: true,
                              allowHalfRating: true,
                              initialRating: trainer.rating,
                              itemSize: 20,
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                half: const Icon(
                                  Icons.star_half,
                                  color: Colors.amber,
                                ),
                                empty: Icon(
                                  Icons.star,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              onRatingUpdate: (value) {},
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${trainer.numberOfRatings.toString()} ratings",
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final Uri phone = Uri(
                            scheme: 'tel',
                            path: trainer.phoneNumber,
                          );
                          if (await canLaunchUrl(phone)) {
                            await launchUrl(phone);
                          } else {
                            showToastMessage(
                              context,
                              'can\'t open phone number',
                              const Icon(
                                Icons.error,
                                color: MyColors.myred2,
                                size: 20,
                              ),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              trainer.phoneNumber,
                              style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.call,
                              size: 15,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(
                color: MyColors.myOrange2.withOpacity(0.4),
                endIndent: 30,
                indent: 30,
              ),
              const SizedBox(height: 10),
              Wrap(
                children: List.generate(
                  trainer.specializations.length,
                  (index) {
                    return Text(
                      "${trainer.specializations[index]}, ",
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    );
                  },
                ),
              ),
              Text(
                trainer.bio,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
