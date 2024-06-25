import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/logic/auth_cubit/auth_cubit.dart';
import 'package:gym/logic/class_bloc/class_bloc.dart';
import 'package:gym/logic/equipment_bloc/equipment_bloc.dart';
import 'package:gym/logic/trainers_bloc/trainers_bloc.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/screens/main_screens/classes_screen.dart';
import 'package:gym/presentation/screens/main_screens/home_screen.dart';
import 'package:gym/presentation/screens/main_screens/profile_screen.dart';
import 'package:gym/presentation/screens/main_screens/trainers_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  bool isLastPage = false;

  final _screens = const [
    HomeScreen(),
    ClassesScreen(),
    TrainersScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    context.read<EquipmentBloc>().add(GetAllEquipment());
    context.read<ClassBloc>().add(GetAllClasses());
    context.read<TrainersBloc>().add(GetAllTrainers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.read<UserBloc>().add(GetUserInfo(userID: state.user.uid));
        }
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: isLastPage
                ? null
                : AppBar(
                    centerTitle: true,
                    title: Image.asset(
                      'assets/img/logo2.png',
                      width: MediaQuery.sizeOf(context).width / 2,
                    ),
                  ),
            body: SizedBox.expand(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == 3;
                  });
                },
                children: _screens,
              ),
            ),
          ),

          //!Google Nav Example
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff1E1E24),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  child: GNav(
                    gap: 9,
                    haptic: false,
                    iconSize: 20,
                    padding:
                        const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
                    backgroundColor: MyColors.myGrey,
                    color: MyColors.mywhite,
                    activeColor: MyColors.mywhite,
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: MyColors.mywhite,
                          fontSize: 16,
                        ),
                    tabs: const [
                      GButton(
                        icon: FontAwesomeIcons.house,
                        text: 'home',
                        iconSize: 20,
                      ),
                      GButton(
                        icon: FontAwesomeIcons.dumbbell,
                        text: 'classes',
                        iconSize: 20,
                      ),
                      GButton(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        icon: FontAwesomeIcons.personRunning,
                        text: 'trainers',
                        iconSize: 25,
                      ),
                      GButton(
                        icon: FontAwesomeIcons.solidUser,
                        text: 'profile',
                        iconSize: 20,
                      ),
                    ],
                    onTabChange: (index) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    },
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 300),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
