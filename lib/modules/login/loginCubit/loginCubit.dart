
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_eat/modules/login/loginCubit/loginCubitStates.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/constants/constants.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginCubit extends Cubit<LoginCubitStates> {
  LoginCubit(LoginCubitStates InitialLoginState) : super(InitialLoginState);


  static LoginCubit get(context) => BlocProvider.of(context);


  Future Login ({
    required String email ,
    required String password ,
    context
  })

  async {
    emit(LoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: '${email}@gmail.com', password: password).then((value)
    {
      emit(LoginSuccessState(value.user!.uid));
     uId = value.user!.uid;
    }).catchError((error)
    {
      print(error.code.toString());
      print(error.message.toString());
      if(error.code.toString()=='user-not-found')
      {
     //   Fluttertoast.showToast(msg: 'الحساب غير مسجل لا يوجد بيانات برقم هذا المستخدم');
        defaultToast(message: 'الحساب غير مسجل لا يوجد بيانات برقم هذا المستخدم', color: Colors.black,context: context);
      }
      else if(error.code.toString()=='wrong-password')
      {
     //  Fluttertoast.showToast(msg: 'كلمه المرور غير صحيحه');
       defaultToast(message: 'كلمه المرور غير صحيحه', color: Colors.black,context: context);
      }
      else if(error.code.toString()=='network-request-failed')
      {
    //    Fluttertoast.showToast(msg: 'لا يوجد انترنت تاكد من اتصالك بالانترنت');
        defaultToast(message: 'لا يوجد انترنت تاكد من اتصالك بالانترنت', color: Colors.black,context: context);
      }
      emit(LoginErrorState(error.toString()));
    });
  }


  bool UnvisibleBassword=true ;
  IconData Suffix= IconBroken.Hide;
  ChangeSuffix () {
    UnvisibleBassword = !UnvisibleBassword;
    UnvisibleBassword ? Suffix =IconBroken.Hide : Suffix= IconBroken.Show ;
    emit(ChangeSuffixLoginState());
  }

  String? LoginImage;

  Stream<QuerySnapshot> GetLoginImage() {
    return FirebaseFirestore.instance.collection('loginImage').snapshots();
  }
}