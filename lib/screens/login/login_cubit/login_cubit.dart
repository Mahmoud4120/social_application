import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/screens/login/login_cubit/login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(LoginInitialStates());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingStates());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      emit(LoginSuccessStates(value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorStates(error.toString()));
    });
  }

  bool obscureText = true;
  IconData suffix = Icons.visibility_outlined;

  void changeObscureText() {
    obscureText = !obscureText;
    suffix =
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_rounded;
    emit(SocialLoginChangePasswordVisibilityStates());
  }
}
