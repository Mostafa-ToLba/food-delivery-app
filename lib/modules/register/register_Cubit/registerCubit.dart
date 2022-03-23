
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_eat/models/registerModel/registemModel.dart';
import 'package:easy_eat/modules/register/register_Cubit/registerCubitStates.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/constants/constants.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


class RegisterCubit extends Cubit<RegisterCubitStates> {
  RegisterCubit(RegisterCubitStates RegisterCubitInitialState) : super(RegisterCubitInitialState);


  static RegisterCubit get(context)=> BlocProvider.of(context);

  Future Register({
    required String email,
    required String name,
    required String phone,
    required String password,
    context
  })
  async {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '${email}@gmail.com', password: password).then((value)
    {
      createUser(name: name,phone: phone,uId:value.user!.uid,email: email,password: password,);
    }).catchError((error)
    {
  //    print(error.code);
  //    print(error.message);
      if(error.code.toString()=='weak-password')
      {
        defaultToast(message: 'كلمه المرور ضعيفه يجب أن تتكون كلمة المرور من 6 أحرف على الأقل', color: Colors.black,context: context);
     //   Fluttertoast.showToast(msg: ' كلمه المرور ضعيفه يجب أن تتكون كلمة المرور من 6 أحرف على الأقل .');
      }

     else if(error.message.toString()=='The email address is already in use by another account.')
       {
         defaultToast(message: 'يوجد بالفعل حساب برقم هذا المستخدم.', color: Colors.black,context: context);
   //    Fluttertoast.showToast(msg: 'يوجد بالفعل حساب برقم هذا المستخدم.');
       }
      else if(error.message.toString()=='The email address is badly formatted.')
      {
        defaultToast(message: 'يجب كتابه رقم الموبايل بطريقه صحيحه', color: Colors.black,context: context);
   //     Fluttertoast.showToast(msg: 'يجب كتابه رقم الموبايل بطريقه صحيحه');
      }
     else if(email.length<10)
      {
    //    Fluttertoast.showToast(msg: 'يجب كتابه رقم الموبايل بطريقه صحيحه');
        defaultToast(message: 'يجب كتابه رقم الموبايل بطريقه صحيحه', color: Colors.black,context: context);
      }
      else if(error.code.toString()=='network-request-failed')
      {
   //     Fluttertoast.showToast(msg: 'لا يوجد انترنت تاكد من اتصالك بالانترنت');
        defaultToast(message: 'لا يوجد انترنت تاكد من اتصالك بالانترنت', color: Colors.black,context: context);
      }
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }
//......

  void createUser({
    String? email,
    String? name,
    String? phone,
    String? password,
    String? uId,
  }) {
    UserModel userModel = UserModel(
        email: email, name: name, phone: phone, uId: uId,osUserID: '',password:password ,image: 'https://firebasestorage.googleapis.com/v0/b/easy-eat-5dd80.appspot.com/o/userFirstPage.jpg?alt=media&token=dba2380c-26ac-4224-bd0c-4390b6376a7d',
    time: DateFormat.yMMMMd().add_jm().format(DateTime.now()),
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(
        userModel.toMap()).then((value) {
          emit(createUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(createUserErrorState());
    });
  }

  //........


  bool UnvisibleBassword=true ;
  IconData Suffix= IconBroken.Hide;
  ChangeSuffix () {
    UnvisibleBassword = !UnvisibleBassword;
    UnvisibleBassword ? Suffix= IconBroken.Hide : Suffix =IconBroken.Show;
    emit(ChangeSuffixRegisterState());
  }

  Future getNotify() async {
   await OneSignal.shared.getPermissionSubscriptionState().then((state) {
      DocumentReference ref = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      ref.update({
        'osUserID': state.subscriptionStatus.userId,
      }).then((value) {
        emit(getNotiftyStateinRegisterState());
      });
    });
    emit(getNotiftyStateinRegisterErrorState());
  }

  Future LoginFromRegisterPage ({
    required String email ,
    required String password ,
  })
  async {
    emit(LoadingLoginStateFromRegister());
  await  FirebaseAuth.instance.signInWithEmailAndPassword(email: '${email}@gmail.com', password: password).then((value)
    {
      uId = value.user!.uid;
      emit(SuccessLoginStateFromRegister(value.user!.uid));
    }).catchError((error)
    {
      print(error.toString());
      emit(ErrorLoginStateFromRegister(error.toString()));
    });
  }
}