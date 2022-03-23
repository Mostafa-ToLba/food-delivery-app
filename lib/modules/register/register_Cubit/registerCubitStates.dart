
abstract class RegisterCubitStates {}
class RegisterCubitInitialState extends RegisterCubitStates {}


// register and Creat User
class createUserSuccessState extends RegisterCubitStates {}
class createUserErrorState extends RegisterCubitStates {}
class RegisterLoadingState extends RegisterCubitStates{}
class RegisterSuccessState extends RegisterCubitStates {}
class RegisterErrorState extends RegisterCubitStates {
  final error;

  RegisterErrorState(this.error);
}
class ChangeSuffixRegisterState extends RegisterCubitStates {}
class getNotiftyStateinRegisterState extends RegisterCubitStates {}
class getNotiftyStateinRegisterErrorState extends RegisterCubitStates {}


class LoadingLoginStateFromRegister extends RegisterCubitStates {}
class SuccessLoginStateFromRegister extends RegisterCubitStates {
  String uid;

  SuccessLoginStateFromRegister( this.uid);
}
class ErrorLoginStateFromRegister extends RegisterCubitStates{
  String error;

  ErrorLoginStateFromRegister( this.error);
}