import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:custom_clippers/Clippers/sin_cosine_wave_clipper.dart';
import 'package:easy_eat/foodLayout/foodLayoutScreen.dart';
import 'package:easy_eat/modules/login/loginCubit/loginCubit.dart';
import 'package:easy_eat/modules/login/loginCubit/loginCubitStates.dart';
import 'package:easy_eat/modules/register/registerScreen.dart';
import 'package:easy_eat/shared/casheHelper/sharedPreferance.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () async {
        bool? result = await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: Text(
              'Warning',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            content: Text('Do you really want to exit ?',
                style: TextStyle(
                  fontSize: 13.sp,
                )),
            actions: [
              TextButton(
                child: Text('Yes',
                    style: TextStyle(
                      fontSize: 11.sp,
                    )),
                onPressed: () => Navigator.pop(c, true),
              ),
              TextButton(
                child: Text('No',
                    style: TextStyle(
                      fontSize: 11.sp,
                    )),
                onPressed: () => Navigator.pop(c, false),
              ),
            ],
          ),
        );
        if (result == null) {
          result = false;
        }
        return result;
      },
      child: BlocProvider(
        create: (BuildContext context) => LoginCubit(InitialLoginState()),
        child: BlocConsumer<LoginCubit, LoginCubitStates>(
          listener: (BuildContext context, state) {
            if (state is LoginSuccessState) {
              CasheHelper.SaveData(key: 'uId', value: state.uId)!.then((value) {
                print(state.uId);
                Fluttertoast.showToast(msg: 'تم تسجيل الدخول بنجاح');
                NavigateAndFinsh(context, FoodLayoutScreen());
              });
            }
          },
          builder: (BuildContext context, Object? state) {
            double screenHieght = MediaQuery.of(context).size.height;
            double screenWidth = MediaQuery.of(context).size.width;
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
              ),
              child: Scaffold(
                //        resizeToAvoidBottomInset:false ,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        child: ClipPath(
                          clipper: SinCosineWaveClipper(),
                          child: Container(
                            width: double.infinity,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: LoginCubit.get(context).GetLoginImage(),
                              builder: (context, snapshot) {
                                String image = '';
                                if (!snapshot.hasData)
                                  return Text("");
                                else {
                                  for (var doc in snapshot.data!.docs)
                                    image = doc['image'];
                                }
                                return Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage('${image}'),
                                );
                              },
                            ),
                            /*
                                   decoration: BoxDecoration
                                     (
                                       image: DecorationImage(fit: BoxFit.cover,image:
                                       NetworkImage('${LoginCubit.get(context).LoginImage}'),)),

                                    */
                            height: 43.h,
                          ),
                        ),
                      ),
                      //    SizedBox(height: 2.h,),
                      Padding(
                        padding:  EdgeInsets.only(top: 2.h),
                        child: Container(
                   //     height: 57.h,
                          child: Padding(
                            padding:  EdgeInsets.only(
                              right: 2.h,
                              left: 2.h,
                            ),
                            child: Container(
                              //     height: 50.h,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 0,
                                    ),
                                    Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: HexColor('#8d2422'),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'سجل دخولك الآن واطلب من التطبيق',
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    defultformfield(
                                      textStyle: TextStyle(fontSize: 13.sp),
                                      controle: emailController,
                                      prefix: IconBroken.Call,
                                      label: 'رقم الموبايل',
                                      keyboard: TextInputType.phone,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'من فضلك ادخل رقم الموبايل';
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    defultformfield(
                                      textStyle: TextStyle(fontSize: 13.sp),
                                      suffixPressed: () {
                                        LoginCubit.get(context).ChangeSuffix();
                                      },
                                      suffix: LoginCubit.get(context).Suffix,
                                      isPassword:
                                          LoginCubit.get(context).UnvisibleBassword,
                                      controle: passwordController,
                                      keyboard: TextInputType.visiblePassword,
                                      prefix: IconBroken.Unlock,
                                      label: 'كلمه المرور',
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'من فضلك ادخل كلمه المرور';
                                        }
                                      },
                                    ),
                                    SizedBox(height: 4.h),
                                    ConditionalBuilder(
                                      condition: state is! LoadingLoginState,
                                      builder: (BuildContext context) => Container(
                                          width: 100.w,
                                          height: 7.h,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40)),
                                              color: HexColor('#8d2422')),
                                          child: MaterialButton(
                                            /*
                                             style: ButtonStyle(
                                               splashFactory: NoSplash.splashFactory,
                                             ),
                                              */
                                            color: HexColor('#7a0000'),
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                LoginCubit.get(context).Login(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,context: context);
                                              }
                                            },
                                            child: Text(
                                              'تسجيل دخول',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      fallback: (BuildContext context) => Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            NavigateTo(context, RegisterScreen());
                                          },
                                          child: Text(
                                            'انشاء حساب',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                              color: HexColor('#8d2422'),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.2.w,
                                        ),
                                        Text('ليس لديك حساب؟',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 11.sp,
                                            )),
                                        SizedBox(height: 2.h,),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
