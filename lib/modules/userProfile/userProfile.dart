import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/modules/openProfilreImage/openProfilePic.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class UserProfile extends StatelessWidget {
   UserProfile({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        FoodCubit.get(context).GetUserDataFunction();
        return BlocConsumer<FoodCubit,FoodCubitStates>(
          listener:(context,state)
          {
            if(state is SocialCubitSignOutSuccessState)
            {
              Fluttertoast.showToast(msg: 'تم تسجيل الخروج بنجاح');
            }
          },
          builder:(context,state)
          {
       //     print(FirebaseAuth.instance.currentUser!.uid);
            nameController.text=FoodCubit.get(context).getUserData.name!;
            emailController.text=FoodCubit.get(context).getUserData.phone!;
            phoneController.text=FoodCubit.get(context).getUserData.email!;
            passwordController.text=FoodCubit.get(context).getUserData.password!;
            return SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.only(right: 2.h,left: 2.h,),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children:
                  [
                    if(SizerUtil.deviceType == DeviceType.mobile)
                    Container(
                      height: 27.h,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 19.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10) ),
                                  image: DecorationImage(image: AssetImage('Assets/images/profileCover.jpg',),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                          ),
                          InkWell(
                          //  splashColor: Colors.black,
                            highlightColor:Colors.white,
                            child: Stack(
                              alignment:AlignmentDirectional.bottomCenter ,
                              children: [
                                CircleAvatar(
                                  radius: 59.sp,backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 56.sp ,
                                    child: StreamBuilder <QuerySnapshot>(
                                      stream: FoodCubit.get(context).gET(),
                                      builder: (context, snapshot)
                                      {
                                        if(!snapshot.hasData||snapshot.data!.size==0)
                                          return Center(child: Text('',style: TextStyle(fontSize: 20.sp),));
                                        else
                                        {
                                          for(var doc in snapshot.data!.docs)
                                          {
                                            if(doc.id==FirebaseAuth.instance.currentUser?.uid)
                                              return CircleAvatar(
                                                radius: 62.sp,
                                                backgroundImage:  NetworkImage('${doc['image']}',),
                                              );
                                          }
                                        }
                                        return Text('',style: TextStyle(color: Colors.white),);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 20.w,bottom: .3.h),
                                  child: CircleAvatar(
                                    radius: 15.sp,
                                    child: IconButton(iconSize:23.sp,onPressed: ()
                                    {
                                      FoodCubit.get(context).getProfileImage();
                                    }, icon: Icon(IconBroken.Camera,size: 18.sp,),padding: EdgeInsetsDirectional.zero,),
                                  ),
                                ),
                              ],
                            ),
                            onTap: ()
                            {
                              FoodCubit.get(context).GetUserDataFunction().then((value)
                              {
                                NavigateTo(context, ProfilePicPhotoOpen(FoodCubit.get(context).getUserData.image!));
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    if(SizerUtil.deviceType == DeviceType.tablet)
                      Container(
                        height: 34.h,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Container(
                                height: 23.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10) ),
                                    image: DecorationImage(image: AssetImage('Assets/images/profileCover.jpg',),
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                            ),
                            InkWell(
                              //  splashColor: Colors.black,
                              highlightColor:Colors.white,
                              child: Stack(
                                alignment:AlignmentDirectional.bottomCenter ,
                                children: [
                                  CircleAvatar(
                                    radius: 58.sp,backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 55.sp ,
                                      child: StreamBuilder <QuerySnapshot>(
                                        stream: FoodCubit.get(context).gET(),
                                        builder: (context, snapshot)
                                        {
                                          if(!snapshot.hasData||snapshot.data!.size==0)
                                            return Center(child: Text('',style: TextStyle(fontSize: 20.sp),));
                                          else
                                          {
                                            for(var doc in snapshot.data!.docs)
                                            {
                                              if(doc.id==FirebaseAuth.instance.currentUser?.uid)
                                                return CircleAvatar(
                                                  radius: 62.sp,
                                                  backgroundImage:  NetworkImage('${doc['image']}',),
                                                );
                                            }
                                          }
                                          return Text('',style: TextStyle(color: Colors.white),);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 20.w,bottom: .3.h),
                                    child: CircleAvatar(
                                      radius: 15.sp,
                                      child: IconButton(iconSize:23.sp,onPressed: ()
                                      {
                                        FoodCubit.get(context).getProfileImage();
                                      }, icon: Icon(IconBroken.Camera,size: 17.sp,),padding: EdgeInsetsDirectional.zero,),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: ()
                              {
                                FoodCubit.get(context).GetUserDataFunction().then((value)
                                {
                                  NavigateTo(context, ProfilePicPhotoOpen(FoodCubit.get(context).getUserData.image!));
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    if(state is UploadProfileImageLoadingState)
                      Column(
                        children: [
                          SizedBox(height: 1.h,),
                          Container(width: 80.w,height: .5.h,child: LinearProgressIndicator(backgroundColor: Colors.grey[300],)),
                        ],
                      ),
              //      SizedBox(height: 1.h,),
                    Container(
               //       height: 55.h,
                      child: Form(
                        child: Column(
                   //       mainAxisAlignment: MainAxisAlignment.center,
                   //       crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children:
                          [
                            ConditionalBuilder(
                              condition: true,
                              builder: (BuildContext context) {
                                return Column(
                                  children: [
                                    SizedBox(height: 1.h,),
                                    defultformfield(
                                      textStyle: TextStyle(fontSize: 13.sp),
                                      controle: nameController,
                                      keyboard: TextInputType.text,
                                      prefix: IconBroken.User,
                                      label: 'الاسم',
                                    ),
                                    SizedBox(height: 2.h,),
                                    defultformfield(
                                      textStyle: TextStyle(fontSize: 13.sp),
                                      controle: emailController,
                                      keyboard: TextInputType.emailAddress,
                                      prefix: IconBroken.Message,
                                      label: 'البريد الالكتروني',
                                    ),
                                    SizedBox(height: 2.h,),
                                    defultformfield(
                                      textStyle: TextStyle(fontSize: 13.sp),
                                      controle: phoneController,
                                      keyboard: TextInputType.phone,
                                      prefix: IconBroken.Call,
                                      label: 'رقم الموبايل',
                                    ),
                                    SizedBox(height: 2.h),
                                    defultformfield(
                                      textStyle: TextStyle(fontSize: 13.sp),
                                      suffixPressed:()
                                      {

                                      } ,
                                      controle: passwordController,
                                      keyboard: TextInputType.visiblePassword,
                                      prefix: IconBroken.Lock,
                                      label: 'كلمه المرور',
                                    ),
                                  ],
                                );
                              },
                              fallback: (BuildContext context) {
                                return Center(child: Container(height: 4.h,width:4.h ,child: CircularProgressIndicator(color: Colors.white,)));
                              },
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: HexColor('#7a0000'),
                                    height: 7.h,
                                    width: 100.w,
                                    child: OutlinedButton(onPressed: ()
                                    {
                                      FoodCubit.get(context).SignUpshowAlertDialog(context);
                                    }, child: Text('تسجيل الخروج',style: TextStyle(fontSize: 15
                                        .sp,color: Colors.white),)),
                                  ),
                                ),
                                SizedBox(width: 2.w,),
                                Expanded(
                                  child: Container(
                                    color: HexColor('#7a0000'),
                                    height: 7.h,
                                    width: 100.w,
                                    child: OutlinedButton(onPressed: ()
                                    {
                                      FoodCubit.get(context).ShowDialogForUpdating(context,NameController:nameController.text,PhoneController:phoneController.text,
                                      EmailController:emailController.text,PasswordController:passwordController.text);
                                   //   FoodCubit.get(context).updateData(name: nameController.text,phone: phoneController.text,email:
                                    //  emailController.text,password: passwordController.text);
                                    }, child: Text('تحديث البيانات',style: TextStyle(fontSize: 15
                                        .sp,color: Colors.white),)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } ,
        );
      },
    );
  }
}
