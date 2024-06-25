import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/presentation/widgets/toast.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final _forgotpasswordcontroller = TextEditingController();
  final formKey3 = GlobalKey<FormState>();
  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            showToastMessage(
              context,
              state.errorMessage,
              const Icon(
                Icons.error,
                color: MyColors.myred2,
                size: 20,
              ),
            );
          } else if (state is UserInitial) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              'mainscreen',
              (Route<dynamic> route) => false,
            );
            showToastMessage(
              context,
              'Reset Password link has been sent to your email',
              const Icon(
                Icons.done,
                color: Colors.green,
                size: 20,
              ),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: const IconThemeData(color: MyColors.myOrange2),
              ),
              Expanded(
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Form(
                          key: formKey3,
                          child: Column(
                            children: [
                              Text(
                                'Enter Your Email',
                                style: GoogleFonts.nunito(
                                  color: MyColors.myOrange2,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 25),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: MyColors.myOrange2,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextFormField(
                                        controller: _forgotpasswordcontroller,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null ||
                                              !EmailValidator.validate(value)) {
                                            return 'Enter a valid email';
                                          }
                                          return null;
                                        },
                                        style: GoogleFonts.nunito(
                                          color: MyColors.mywhite,
                                          fontSize: 16,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Email...',
                                          hintStyle: TextStyle(
                                              color: MyColors.mywhite),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              state is UserLoading
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 70,
                                          height: 40,
                                          child: Lottie.asset(
                                              'assets/lottie/SplashyLoader.json'),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final isValid = formKey3
                                                  .currentState!
                                                  .validate();
                                              if (!isValid) return;
                                              context.read<UserBloc>().add(
                                                    ResetPassword(
                                                      email:
                                                          _forgotpasswordcontroller
                                                              .text
                                                              .trim(),
                                                    ),
                                                  );
                                            },
                                            child: Container(
                                              width: 140,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: MyColors.myOrange2,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Reset Password',
                                                  style: GoogleFonts.nunito(
                                                    color: MyColors.myOrange2,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
