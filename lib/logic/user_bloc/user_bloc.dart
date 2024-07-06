import 'package:gym/data/models/usr_model.dart';
import 'package:gym/data/services/user_services.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final usersServices = UserServices();
    UserCredential userCredentials;

    on<SignIn>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          userCredentials =
              await usersServices.signIn(event.email, event.password);
          add(GetUserInfo(userID: userCredentials.user!.uid));
          print(state);
        } catch (e) {
          emit(const UserError('Error Sining In'));
          print(state);
        }
      },
    );

    on<SignOut>(
      (event, emit) {
        usersServices.signOut();
      },
    );

    on<SignUp>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          userCredentials = await usersServices.signUp(
            email: event.email,
            password: event.password,
            firstName: event.firstName,
            lastName: event.lastName,
            phoneNumber: event.phoneNumber,
            age: event.age,
            gender: event.gender,
            role: event.role,
            profilePicture: event.profilePicture,
            assignedClasses: event.assignedClasses,
            bio: event.bio,
            enrolledClasses: event.enrolledClasses,
            height: event.height,
            weight: event.weight,
            rating: event.rating,
            specializations: event.specializations,
          );
          add(GetUserInfo(userID: userCredentials.user!.uid));
          print(state);
        } catch (e) {
          emit(const UserError('Error Signing Up'));
          print(state);
        }
      },
    );

    on<ResetPassword>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          usersServices.resetPassword(event.email);
          emit(UserInitial());
          print(state);
        } catch (e) {
          emit(const UserError('Error Resetting Password'));
          print(state);
        }
      },
    );

    on<GetUserInfo>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          final userInfo = await usersServices.getUserInfo(event.userID);
          print(userInfo);
          // final userCars = await usersServices.getUserCars(event.userID);
          emit(UserLoaded(userInfo: userInfo!));
          print(state);
        } catch (e) {
          emit(const UserError('Failed to load user information'));
          print(state);
          print(e);
        }
      },
    );

    on<AddUserImage>(
      (event, emit) async {
        try {
          // emit(UserLoading());
          // print(state);
          usersServices.addImage(event.imageUrl, event.userID);
          add(GetUserInfo(userID: event.userID));
          // emit(UserInitial());
          // print(state);
        } catch (e) {
          emit(const UserError('Error Adding Image'));
          print(state);
        }
      },
    );

    on<AddUserPhoneNumber>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          usersServices.addPhoneNumber(event.phoneNumber, event.userID);
          emit(UserInitial());
          add(GetUserInfo(userID: event.userID));
          print(state);
        } catch (e) {
          emit(const UserError('Error Adding Number'));
          print(state);
        }
      },
    );

    on<AddUserHeight>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          usersServices.addHeight(event.height, event.userID);
          emit(UserInitial());
          add(GetUserInfo(userID: event.userID));
          print(state);
        } catch (e) {
          emit(const UserError('Error Adding Height'));
          print(state);
        }
      },
    );

    on<AddUserWeight>(
      (event, emit) async {
        try {
          emit(UserLoading());
          print(state);
          usersServices.addWeight(event.weight, event.userID);
          emit(UserInitial());
          add(GetUserInfo(userID: event.userID));
          print(state);
        } catch (e) {
          emit(const UserError('Error Adding Weight'));
          print(state);
        }
      },
    );
  }
}
