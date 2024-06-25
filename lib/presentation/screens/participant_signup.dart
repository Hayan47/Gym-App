import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/widgets/dropdown.dart';
import 'package:gym/presentation/widgets/toast.dart';
import 'package:lottie/lottie.dart';

class ParticipantSignup extends StatefulWidget {
  const ParticipantSignup({super.key});

  @override
  State<ParticipantSignup> createState() => _ParticipantSignupState();
}

class _ParticipantSignupState extends State<ParticipantSignup> {
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  int dropDownValue = 19;
  String dropDownValue2 = 'male';

  var ages = List<int>.generate(100, (i) => i + 1);
  var genders = ['male', 'female'];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
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
            'welcome ${state.userInfo.firstName}',
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
            Expanded(
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  //!first name TextField
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 25),
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
                                              textAlign: TextAlign.center,
                                              controller: _firstnamecontroller,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) {
                                                if (value == '') {
                                                  return 'Enter a name';
                                                }
                                                return null;
                                              },
                                              style: GoogleFonts.nunito(
                                                color: MyColors.mywhite,
                                                fontSize: 16,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'First Name',
                                                helperText: '',
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
                                  ),
                                  const SizedBox(width: 25),
                                  //!last name TextField
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 25),
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
                                              textAlign: TextAlign.center,
                                              controller: _lastnamecontroller,
                                              style: GoogleFonts.nunito(
                                                color: MyColors.mywhite,
                                                fontSize: 16,
                                              ),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Last Name',
                                                helperText: '',
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
                                  ),
                                ],
                              ),

                              //!age Dropdown button
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MyDropdown(
                                    icon: 'assets/icons/age.png',
                                    width: 80,
                                    dropdownValue: dropDownValue,
                                    label: 'age',
                                    items: ages
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Center(child: Text('$e')),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropDownValue = value;
                                      });
                                    },
                                  ),
                                  MyDropdown(
                                    icon: 'assets/icons/gender.png',
                                    width: 80,
                                    dropdownValue: dropDownValue2,
                                    label: 'gender',
                                    items: genders
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Center(child: Text(e)),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropDownValue2 = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              //!Phone TextField
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
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.phone,
                                        controller: _phonecontroller,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null ||
                                              value.length < 10) {
                                            return 'Enter a valid phone number';
                                          }
                                          return null;
                                        },
                                        style: GoogleFonts.nunito(
                                          color: MyColors.mywhite,
                                          fontSize: 16,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Phone Number...',
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
                              //!Email TextField
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
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _emailcontroller,
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
                              //!Password TextField
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
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        controller: _passwordcontroller,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null ||
                                              value.length < 8) {
                                            return 'password should be 6 chrachters or more';
                                          }
                                          return null;
                                        },
                                        style: GoogleFonts.nunito(
                                          color: MyColors.mywhite,
                                          fontSize: 16,
                                        ),
                                        obscureText: hidePassword,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                hidePassword = !hidePassword;
                                              });
                                            },
                                            icon: Icon(
                                              hidePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: MyColors.mywhite,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'password...',
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
                              //!Confirm Password TextField
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
                                        textInputAction: TextInputAction.done,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        controller: _confirmpasswordcontroller,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value !=
                                              _passwordcontroller.text) {
                                            return 'passwords not matching';
                                          }
                                          return null;
                                        },
                                        style: GoogleFonts.nunito(
                                          color: MyColors.mywhite,
                                          fontSize: 16,
                                        ),
                                        obscureText: hidePassword,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'confirm password...',
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
                              //!Signup Button
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
                                              horizontal: 40),
                                          child: TextButton(
                                            onPressed: () async {
                                              final isValid = formKey
                                                  .currentState!
                                                  .validate();
                                              if (!isValid) return;

                                              context
                                                  .read<UserBloc>()
                                                  .add(SignUp(
                                                    email: _emailcontroller.text
                                                        .trim(),
                                                    password:
                                                        _passwordcontroller.text
                                                            .trim(),
                                                    firstName:
                                                        _firstnamecontroller
                                                            .text
                                                            .trim(),
                                                    lastName:
                                                        _lastnamecontroller.text
                                                            .trim(),
                                                    phoneNumber:
                                                        _phonecontroller.text
                                                            .trim(),
                                                    age: dropDownValue,
                                                    gender: dropDownValue2,
                                                    role: 'participant',
                                                  ));
                                            },
                                            style: ButtonStyle(
                                                shape: WidgetStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10))),
                                                fixedSize:
                                                    WidgetStateProperty.all(
                                                        const Size(70, 40)),
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        MyColors.myOrange2)),
                                            child: Text(
                                              'Sign Up',
                                              style: GoogleFonts.nunito(
                                                color: MyColors.mywhite,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
