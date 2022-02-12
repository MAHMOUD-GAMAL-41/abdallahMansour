
abstract class SocialLoginStates {}

class SocialLoginInitState extends SocialLoginStates {}

class SocialLoginLoadState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uID;
  SocialLoginSuccessState(this.uID);
}

class SocialLoginErrorState extends SocialLoginStates {
  final String error;

  SocialLoginErrorState(this.error);

}
class SocialChangePasswordVisibilityState extends SocialLoginStates {}
