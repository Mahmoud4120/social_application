
abstract class SocialLoginStates{}
class LoginInitialStates extends SocialLoginStates{}
class LoginLoadingStates extends SocialLoginStates{}
class LoginSuccessStates extends SocialLoginStates{
  final String uId;
  LoginSuccessStates(this.uId);
}
class LoginErrorStates extends SocialLoginStates{
  final String error;
  LoginErrorStates(this.error);
}

class SocialLoginChangePasswordVisibilityStates extends SocialLoginStates{}
