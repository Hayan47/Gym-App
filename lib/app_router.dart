import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/data/models/class_model.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/class_bloc/class_bloc.dart';
import 'package:gym/logic/equipment_bloc/equipment_bloc.dart';
import 'package:gym/logic/image_bloc/image_bloc.dart';
import 'package:gym/logic/jobs_bloc/jobs_bloc.dart';
import 'package:gym/logic/membership_bloc/membership_bloc.dart';
import 'package:gym/logic/schedule_bloc/schedule_bloc.dart';
import 'package:gym/logic/trainers_bloc/trainers_bloc.dart';
import 'package:gym/logic/upload_bloc/upload_bloc.dart';
import 'package:gym/logic/user_bloc/user_bloc.dart';
import 'package:gym/presentation/screens/admin/add_equipment_screen.dart';
import 'package:gym/presentation/screens/admin/pending_classes_screen.dart';
import 'package:gym/presentation/screens/admin/pending_memberships_screen.dart';
import 'package:gym/presentation/screens/participant/mymembership_screen.dart';
import 'package:gym/presentation/screens/trainer/assigned_classes_screen.dart';
import 'package:gym/presentation/screens/class_details_screen.dart';
import 'package:gym/presentation/screens/trainer/create_class_screen.dart';
import 'package:gym/presentation/screens/admin/create_job_screen.dart';
import 'package:gym/presentation/screens/admin/edit_schedule_screen.dart';
import 'package:gym/presentation/screens/participant/enrolled_classes_screen.dart';
import 'package:gym/presentation/screens/forget_password.dart';
import 'package:gym/presentation/screens/jobs_screen.dart';
import 'package:gym/presentation/screens/log_in_screen.dart';
import 'package:gym/presentation/screens/main_screen.dart';
import 'package:gym/presentation/screens/schedule_screen.dart';
import 'package:gym/presentation/screens/sign_up_screen.dart';
import 'package:gym/presentation/screens/welcome_screen.dart';

class AppRouter {
  late UserBloc userBloc;
  late EquipmentBloc equipmentBloc;
  late ClassBloc classBloc;
  late ImageBloc imageBloc;
  late UploadBloc uploadBloc;
  late TrainersBloc trainersBloc;
  late JobsBloc jobsBloc;
  late ScheduleBloc scheduleBloc;
  late MembershipBloc membershipBloc;

  AppRouter() {
    userBloc = UserBloc();
    equipmentBloc = EquipmentBloc();
    classBloc = ClassBloc();
    imageBloc = ImageBloc();
    uploadBloc = UploadBloc();
    trainersBloc = TrainersBloc();
    jobsBloc = JobsBloc();
    scheduleBloc = ScheduleBloc();
    membershipBloc = MembershipBloc();
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
              BlocProvider.value(value: membershipBloc),
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
      case 'addequipment':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: imageBloc),
              BlocProvider.value(value: uploadBloc),
              BlocProvider.value(value: equipmentBloc),
            ],
            child: const AddEquipmentScreen(),
          ),
        );
      case 'createjobscreen':
        final Admin admin = settings.arguments as Admin;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: jobsBloc,
            child: CreateJobScreen(admin: admin),
          ),
        );
      case 'jobsscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: jobsBloc,
            child: const JobsScreen(),
          ),
        );

      case 'shedulescreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: scheduleBloc,
            child: const ScheduleScreen(),
          ),
        );
      case 'editschedule':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: scheduleBloc,
            child: const EditScheduleScreen(),
          ),
        );
      case 'pendingclassesscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: classBloc,
            child: const PendingClassesScreen(),
          ),
        );
      case 'mymembershipscreen':
        final Participant participant = settings.arguments as Participant;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: membershipBloc,
            child: MymembershipScreen(participant: participant),
          ),
        );
      case 'pendingmembershipsscreen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: membershipBloc,
            child: const PendingMembershipsScreen(),
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
    jobsBloc.close();
    scheduleBloc.close();
    membershipBloc.close();
  }
}
