import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/screens/register/cubit/register_states.dart';

import '../../../models/user_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(RegisterInitialStates());
  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingStates());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(RegisterErrorStates(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      bio: 'write your bio ....',
      cover: 'https://img.freepik.com/free-vector/alone-concept-illustration_114360-2393.jpg?t=st=1738036572~exp=1738040172~hmac=ac71d135e5ebca5cf2866ea1d9e507bbbf1773c2587d35d578a15f1ce02be047&w=740',
      image:
          'https://img.freepik.com/free-vector/isolated-young-handsome-man-set-different-poses-white-background-illustration_632498-661.jpg?t=st=1738036446~exp=1738040046~hmac=11a75d9b650dae0c4b006febcf4fb533df36d4c627b190257594bc45fedd2d49&w=740',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorStates(error.toString()));
    });
  }

  bool obscureText = true;
  IconData suffix = Icons.visibility_outlined;
  void changeObscureText() {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_rounded;
    emit(SocialRegisterChangePasswordVisibilityStates());
  }
}
