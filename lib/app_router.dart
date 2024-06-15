import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/data/services/user_services.dart';
import 'package:gym/logic/auth_cubit/auth_cubit.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/screens/forget_password.dart';
import 'package:gym/presentation/screens/log_in_screen.dart';
import 'package:gym/presentation/screens/main_screen.dart';
import 'package:gym/presentation/screens/sign_up_screen.dart';
import 'package:gym/presentation/screens/welcome_screen.dart';

class AppRouter {
  late AuthCubit authCubit;
  late UserBloc userBloc;

  AppRouter() {
    authCubit = AuthCubit(userServices: UserServices());
    userBloc = UserBloc();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case 'mainscreen':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: authCubit),
                    BlocProvider.value(value: userBloc),
                  ],
                  child: MainScreen(),
                ));
      case 'loginscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: userBloc,
            child: const LogInScreen(),
          ),
        );
      case 'signupscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: userBloc,
            child: const SignUpScreen(),
          ),
        );
      case 'forgetpasswordscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: userBloc,
            child: ForgetPasswordScreen(),
          ),
        );
    }
    return null;
  }

  void dispose() {}
}
