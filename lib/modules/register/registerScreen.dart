
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_eat/modules/onBoarding/onBoardingScreen.dart';
import 'package:easy_eat/modules/register/register_Cubit/registerCubit.dart';
import 'package:easy_eat/modules/register/register_Cubit/registerCubitStates.dart';
import 'package:easy_eat/shared/casheHelper/sharedPreferance.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:sizer/sizer.dart';

//#bfffd6

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
   var nameController = TextEditingController();
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var phoneController = TextEditingController();
   var formKey = GlobalKey<FormState>();
   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> RegisterCubit(RegisterCubitInitialState()),
      child: BlocConsumer<RegisterCubit,RegisterCubitStates>(
        listener: (BuildContext context ,state)
        {
          {
            if(state is createUserSuccessState)
            {
              Fluttertoast.showToast(msg: 'تم انشاء الحساب بنجاح');
              NavigateAndFinsh(context, OnboardingScreen());
            }
          }
         if(state is SuccessLoginStateFromRegister)
           {
             CasheHelper.SaveData(key: 'uId', value:state.uid);
           }
        },
        builder: (BuildContext context,state)
        {
          return Container(
            height: 100.h,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
              ),
              child: Scaffold(
                body:SingleChildScrollView(
                  child: Container(
               //     height: 100.h,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipPath(
                              clipper:DirectionalWaveClipper(),
                              child: Container(
                                height: 40.h,
                                color: HexColor('#fff0e0'),
                                alignment: Alignment.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(6.h),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(backgroundColor: Colors.white,radius: 3.h),
                                  IconButton(iconSize: 4.h,onPressed: ()
                                  {
                                    Navigator.pop(context);
                                  }, icon: Icon(IconBroken.Arrow___Left_2,color:HexColor('#7a0000'),size: 3.h ,)),
                                ],
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top: 0.h),
                              child: Padding(
                                padding:  EdgeInsets.only(top: 10.h),
                                child: Container(
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: 2.h,right: 2.h,),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children:
                                        [
                                          SizedBox(height: 6.h,),
                                          Text('انشاء حساب',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w600,color:HexColor('#7a0000')),),
                                          Text('سجل حسابا جديدا برقم الموبايل ',style: TextStyle(fontSize: 13.sp,color:Colors.grey,fontWeight: FontWeight.w600),),
                                          SizedBox(height: 3.h,),
                                          defultformfield(
                                            textStyle: TextStyle(fontSize: 13.sp),
                                            controle: nameController,
                                            keyboard: TextInputType.text,
                                            prefix: IconBroken.User,
                                            label: '* الاسم',
                                            validate:(value)
                                            {
                                              if(value.isEmpty)
                                              {
                                                return'من فضلك ادخل الاسم ';
                                              }
                                            },
                                          ),
                                          SizedBox(height: 2.5.h,),
                                          defultformfield(
                                            textStyle: TextStyle(fontSize: 13.sp),
                                            controle: phoneController,
                                            keyboard: TextInputType.emailAddress,
                                            prefix: IconBroken.Message,
                                            label: '* البريد الالكتروني (اختياري)',
                                          ),
                                          SizedBox(height: 2.5.h,),
                                          defultformfield(
                                            textStyle: TextStyle(fontSize: 13.sp),
                                            controle: emailController,
                                            keyboard: TextInputType.phone,
                                            prefix: IconBroken.Call,
                                            label: '* رقم الموبايل',
                                            validate:(value)
                                            {
                                              if(value.isEmpty)
                                              {
                                                return'من فضلك ادخل رقم الموبايل ';
                                              }
                                              if(value.length<10)
                                                {
                                                  return'رقم الموبايل غير صحيح ';
                                                }
                                            },
                                          ),
                                          SizedBox(height: 2.5.h,),
                                          defultformfield(
                                            textStyle: TextStyle(fontSize: 13.sp),
                                            isPassword:RegisterCubit.get(context).UnvisibleBassword,
                                            suffixPressed:()
                                            {
                                              RegisterCubit.get(context).ChangeSuffix();
                                            } ,
                                            suffix: RegisterCubit.get(context).Suffix,
                                            controle: passwordController,
                                            keyboard: TextInputType.visiblePassword,
                                            prefix: IconBroken.Lock,
                                            label: '* كلمه المرور',
                                            validate:(value)
                                            {
                                              if(value.isEmpty)
                                              {
                                                return'من فضلك ادخل كلمه المرور';
                                              }
                                            },
                                          ),
                                          SizedBox(height: 6.h,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('By signing you agree to our',style: TextStyle(fontSize: 11.sp,color:HexColor('#8d2422') ),),
                                                 Text(' terms of use',style: TextStyle(fontSize: 11.sp,color:Colors.grey),),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(' and ',style: TextStyle(fontSize: 11.sp,color:HexColor('#8d2422')),),
                                                  Text('privacy notice',style: TextStyle(fontSize: 11.sp,color:Colors.grey),),
                                                ],
                                              ),

                                            ],
                                          ),
                                          SizedBox(height: 2.h,),
                                          ConditionalBuilder(
                                              condition: state is! RegisterLoadingState && state is! LoadingLoginStateFromRegister,
                                              builder: (BuildContext context)=>Container(
                                                  width: 100.w,
                                                  height: 7.h,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40.h)),color:  HexColor('#8d2422')),
                                                  child: MaterialButton(
                                                    /*
                                                    style: ButtonStyle(
                                                      splashFactory: NoSplash.splashFactory,
                                                    ),
                                                     */
                                                    color: HexColor('#7a0000'),
                                                    onPressed: ()
                                                  {
                                                    if(formKey.currentState!.validate())
                                                    {
                                                      RegisterCubit.get(context).Register(email: emailController.text,phone: phoneController.text,password:
                                                      passwordController.text,name: nameController.text,context: context).then((value)
                                                       {
                                                        RegisterCubit.get(context).LoginFromRegisterPage(email: emailController.text, password: passwordController.text);
                                                      });
                                                    }
                                                  }
                                                    ,child: Text('انشاء حساب',style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold),),)
                                              ),
                                              fallback: (BuildContext context)=>Center(child: CircularProgressIndicator())
                                          ),
                                          SizedBox(height: 3.h,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
