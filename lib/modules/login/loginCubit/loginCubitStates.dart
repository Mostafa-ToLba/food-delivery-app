
abstract class LoginCubitStates {}

class InitialLoginState extends LoginCubitStates {}
class LoadingLoginState extends LoginCubitStates {}
class LoginSuccessState extends LoginCubitStates {
  final uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginCubitStates {
  final error;
  LoginErrorState(this.error);
}

class ChangeSuffixLoginState extends LoginCubitStates {}


