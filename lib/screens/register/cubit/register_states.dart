abstract class  SocialRegisterState {}
class RegisterInitialStates extends SocialRegisterState {}
class RegisterLoadingStates extends SocialRegisterState {}
class RegisterSuccessStates extends SocialRegisterState {}
class RegisterErrorStates extends SocialRegisterState {
 final String error;
  RegisterErrorStates(this.error);
}
class SocialCreateUserSuccessStates extends SocialRegisterState {}
class SocialCreateUserErrorStates extends SocialRegisterState {
 final String error;
  SocialCreateUserErrorStates(this.error);
}
class SocialRegisterChangePasswordVisibilityStates extends SocialRegisterState{}