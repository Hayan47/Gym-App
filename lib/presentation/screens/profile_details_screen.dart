import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/admin_bloc/admin_bloc.dart';
import 'package:gym/logic/image_bloc/image_bloc.dart';
import 'package:gym/logic/upload_bloc/upload_bloc.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/screens/admin/admin_panel_screen.dart';
import 'package:gym/presentation/screens/participant/participant_details.dart';
import 'package:gym/presentation/screens/trainer/trainer_details_screen.dart';
import 'package:gym/presentation/widgets/add_phone_number.dart';
import 'package:gym/presentation/widgets/alert_dialog.dart';
import 'package:gym/presentation/widgets/shimmer_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/presentation/widgets/toast.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          if (userState.userInfo is Admin) {
            final admin = (userState.userInfo as Admin);
            return BlocProvider(
              create: (context) => AdminBloc(),
              child: AdminPanelScreen(admin: admin),
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.sizeOf(context).height * 0.32,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Stack(
                      children: [
                        Container(
                          height:
                              MediaQuery.sizeOf(context).height * 0.32 * 0.15,
                          color: Colors.black38,
                        ),
                        Positioned(
                          top: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '${userState.userInfo.firstName} ${userState.userInfo.lastName}',
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.mywhite,
                                    fontSize: 0.4 *
                                        MediaQuery.sizeOf(context).height *
                                        0.32 *
                                        0.15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.call,
                                      size: 12,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          barrierColor: Colors.transparent,
                                          context: context,
                                          builder: (_) {
                                            return BlocProvider.value(
                                              value: BlocProvider.of<UserBloc>(
                                                  context),
                                              child: AddPhoneNumber(
                                                  id: userState
                                                      .userInfo.userid),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        userState.userInfo.phoneNumber,
                                        style: GoogleFonts.nunito(
                                          color: MyColors.mywhite,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    centerTitle: false,
                    titlePadding: EdgeInsets.zero,
                    background: BlocListener<ImageBloc, ImageState>(
                      listener: (context, state) {
                        if (state is ImageChanged) {
                          context.read<UploadBloc>().add(
                                UploadImagesEvent(
                                  image: state.image,
                                  path:
                                      'profile pictures/${userState.userInfo.email}',
                                ),
                              );
                        }
                      },
                      child: BlocConsumer<UploadBloc, UploadState>(
                        listener: (context, state) {
                          if (state is UploadFailedState) {
                            showToastMessage(
                              context,
                              state.message,
                              const Icon(
                                Icons.error,
                                color: MyColors.myred2,
                                size: 20,
                              ),
                            );
                          } else if (state is UploadSuccessState) {
                            context.read<UserBloc>().add(AddUserImage(
                                imageUrl: state.imageUrl,
                                userID: userState.userInfo.userid));
                            showToastMessage(
                              context,
                              state.message,
                              const Icon(
                                Icons.done,
                                color: Colors.green,
                                size: 20,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is UploadingState) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: MyColors.myOrange2),
                            );
                          } else {
                            return CachedNetworkImage(
                              imageUrl:
                                  (userState.userInfo.profilePicture != null)
                                      ? userState.userInfo.profilePicture!
                                      : 'https://i.imgur.com/sWmIhUZ.png',
                              fit: BoxFit.cover,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<ImageBloc>().add(const AddImageEvent());
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) {
                          if (userState.userInfo is Trainer) {
                            final trainer = (userState.userInfo as Trainer);
                            return TrainerDetailsScreen(trainer: trainer);
                          } else {
                            final participant =
                                (userState.userInfo as Participant);
                            return ParticipantDetails(participant: participant);
                          }
                        },
                      ),

                      //! sign out
                      Padding(
                        padding: const EdgeInsets.only(bottom: 90),
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return BlocProvider.value(
                                  value: context.read<UserBloc>(),
                                  child: MyAlertDialog(
                                      onPressed: () {
                                        context.read<UserBloc>().add(SignOut());
                                        Navigator.pop(context);
                                      },
                                      text:
                                          'Are you sure you want to sign out?'),
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(MyColors.myOrange2),
                          ),
                          child: Text(
                            'Sign out',
                            style: GoogleFonts.nunito(
                              color: MyColors.mywhite,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        } else {
          return const ProfileLoading();
        }
      },
    );
  }
}
