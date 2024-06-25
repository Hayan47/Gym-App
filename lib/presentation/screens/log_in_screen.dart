import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/presentation/widgets/toast.dart';
import 'package:lottie/lottie.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool hidePassword = true;

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final formKey2 = GlobalKey<FormState>();

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
          } else if (state is UserLoaded) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              'mainscreen',
              (Route<dynamic> route) => false,
            );
            showToastMessage(
              context,
              'welcome back  ${state.userInfo.firstName}',
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
              //?app bar
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: const IconThemeData(color: MyColors.myOrange2),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        //?main column
                        child: Form(
                          key: formKey2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 15),
                                  //!first message
                                  Text(
                                    'Hello Again!',
                                    style: GoogleFonts.nunito(
                                      color: MyColors.myOrange2,
                                      fontSize: 38,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  //!second message
                                  Text(
                                    'welcome back, you have been missed!',
                                    style: GoogleFonts.nunito(
                                      color: MyColors.myOrange2,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  //!email TextField
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: MyColors.myOrange2,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: GoogleFonts.nunito(
                                              color: MyColors.mywhite,
                                              fontSize: 16,
                                            ),
                                            controller: _emailcontroller,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) {
                                              if (value == null ||
                                                  !EmailValidator.validate(
                                                      value)) {
                                                return 'Enter a valid email';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Email...',
                                              hintStyle: GoogleFonts.nunito(
                                                color: MyColors.mywhite,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  //!password TextField
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: MyColors.myOrange2,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: TextFormField(
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            obscureText: hidePassword,
                                            style: GoogleFonts.nunito(
                                              color: MyColors.mywhite,
                                              fontSize: 16,
                                            ),
                                            controller: _passwordcontroller,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.length < 8) {
                                                return 'password is short';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      hidePassword =
                                                          !hidePassword;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    hidePassword
                                                        ? Icons.visibility_off
                                                        : Icons.visibility,
                                                    color: MyColors.mywhite,
                                                  )),
                                              border: InputBorder.none,
                                              hintText: 'Password...',
                                              hintStyle: GoogleFonts.nunito(
                                                color: MyColors.mywhite,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  //!forget password
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context, 'forgetpasswordscreen'),
                                          child: Text(
                                            'Forget password?',
                                            style: GoogleFonts.nunito(
                                              color: MyColors.myOrange2,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  //!login Button
                                  state is UserLoading
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: TextButton(
                                                onPressed: () async {
                                                  final isValid = formKey2
                                                      .currentState!
                                                      .validate();
                                                  if (!isValid) return;
                                                  context.read<UserBloc>().add(
                                                      SignIn(
                                                          email:
                                                              _emailcontroller
                                                                  .text,
                                                          password:
                                                              _passwordcontroller
                                                                  .text));
                                                },
                                                style: ButtonStyle(
                                                  shape: WidgetStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10))),
                                                  fixedSize:
                                                      WidgetStateProperty.all(
                                                          const Size(70, 40)),
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                    MyColors.myOrange2,
                                                  ),
                                                ),
                                                child: Text(
                                                  'log in',
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
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //!sign up message
                                  Text(
                                    'ain\'t member yet?',
                                    style: GoogleFonts.nunito(
                                      color: MyColors.myOrange2,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                        context, 'signupscreen'),
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.nunito(
                                        color: MyColors.myOrange2,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
