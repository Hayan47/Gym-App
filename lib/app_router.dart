import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/data/models/class_model.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/class_bloc/class_bloc.dart';
import 'package:gym/logic/equipment_bloc/equipment_bloc.dart';
import 'package:gym/logic/image_bloc/image_bloc.dart';
import 'package:gym/logic/trainers_bloc/trainers_bloc.dart';
import 'package:gym/logic/upload_bloc/upload_bloc.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/screens/assigned_classes_screen.dart';
import 'package:gym/presentation/screens/class_details_screen.dart';
import 'package:gym/presentation/screens/create_class_screen.dart';
import 'package:gym/presentation/screens/enrolled_classes_screen.dart';
import 'package:gym/presentation/screens/forget_password.dart';
import 'package:gym/presentation/screens/log_in_screen.dart';
import 'package:gym/presentation/screens/main_screen.dart';
import 'package:gym/presentation/screens/sign_up_screen.dart';
import 'package:gym/presentation/screens/welcome_screen.dart';

class AppRouter {
  late UserBloc userBloc;
  late EquipmentBloc equipmentBloc;
  late ClassBloc classBloc;
  late ImageBloc imageBloc;
  late UploadBloc uploadBloc;
  late TrainersBloc trainersBloc;

  AppRouter() {
    userBloc = UserBloc();
    equipmentBloc = EquipmentBloc();
    classBloc = ClassBloc();
    imageBloc = ImageBloc();
    uploadBloc = UploadBloc();
    trainersBloc = TrainersBloc();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case 'mainscreen':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: userBloc),
              BlocProvider.value(value: equipmentBloc),
              BlocProvider.value(value: classBloc),
              BlocProvider.value(value: trainersBloc),
            ],
            child: MainScreen(),
          ),
        );
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
      case 'createclassscreen':
        final trainer = settings.arguments as Trainer;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: imageBloc),
              BlocProvider.value(value: uploadBloc),
              BlocProvider.value(value: classBloc),
            ],
            child: CreateClassScreen(trainer: trainer),
          ),
        );
      case 'assignedclassesscreen':
        final String trainerId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: classBloc,
            child: AssignedClassesScreen(trainerId: trainerId),
          ),
        );
      case 'classdetailsscreen':
        final gymClass = settings.arguments as GymClass;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: trainersBloc),
              BlocProvider.value(value: userBloc),
              BlocProvider.value(value: classBloc),
            ],
            child: ClassDetailsScreen(gymClass: gymClass),
          ),
        );
      case 'enrolledclassesscreen':
        final String participantId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: classBloc,
            child: EnrolledClassesScreen(participantId: participantId),
          ),
        );
    }
    return null;
  }

  void dispose() {
    userBloc.close();
    equipmentBloc.close();
    classBloc.close();
    imageBloc.close();
    uploadBloc.close();
    trainersBloc.close();
  }
}
