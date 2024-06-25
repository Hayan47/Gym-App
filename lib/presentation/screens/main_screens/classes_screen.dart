import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/auth_cubit/auth_cubit.dart';
import 'package:gym/logic/class_bloc/class_bloc.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/widgets/class_card.dart';
import 'package:gym/presentation/widgets/shimmer_classes.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ClassBloc>().add(GetAllClasses());
    return Scaffold(
      body: BlocBuilder<ClassBloc, ClassState>(
        builder: (context, state) {
          if (state is ClassLoaded) {
            return ListView.builder(
              itemCount: state.gymclasses.length,
              itemBuilder: (context, index) {
                return ClassCard(gymClass: state.gymclasses[index]);
              },
            );
          } else {
            return const ClassesLoading();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  if (state.userInfo is Trainer) {
                    final trainer = (state.userInfo as Trainer);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.pushNamed(context, 'createclassscreen',
                              arguments: trainer);
                        },
                        backgroundColor: MyColors.myOrange2,
                        label: Text(
                          "crate class",
                          style: GoogleFonts.nunito(
                            color: MyColors.mywhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
