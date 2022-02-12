import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ex2/models/social_app/social_user_model.dart';
import 'package:ex2/modules/social_app/register/social_register_cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String? email,
    required String? password,
    required String? name,
    required String? phone,
  }) {
    print('hello');
    emit(SocialRegisterLoadState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(email: email, uID: value.user!.uid, name: name, phone: phone,password: password);
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String? email,
    required String? uID,
    required String? name,
    required String? phone,
    required String? password,
  }) {
    socialUserModel model = socialUserModel(
      phone: phone!,
      email: email!,
      bio: 'Write your bio ...',
      name: name!,
      uId: uID!,
      image: 'https://image.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg',
      cover: 'https://image.freepik.com/free-vector/character-illustration-people-holding-user-account-icons_53876-66068.jpg',
      password:password!,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
