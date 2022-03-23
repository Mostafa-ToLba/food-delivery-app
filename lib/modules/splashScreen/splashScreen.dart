
 import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_eat/foodLayout/foodLayoutScreen.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/modules/login/loginCubit/loginCubit.dart';
import 'package:easy_eat/modules/login/loginCubit/loginCubitStates.dart';
import 'package:easy_eat/modules/login/login_screen.dart';
import 'package:easy_eat/shared/casheHelper/sharedPreferance.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/constants/constants.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({Key? key}) : super(key: key);

   @override
   _SplashScreenState createState() => _SplashScreenState();
 }

 class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    Timer(Duration(seconds: 6),()
    {
      if(uId!= null)
      {
        print(uId);
        NavigateAndFinsh(context, FoodLayoutScreen());
      }else
      {
        print(uId);
        NavigateAndFinsh(context, LoginScreen());
      }
    });
  }
   @override
   Widget build(BuildContext context) {
         return WillPopScope(
           onWillPop: () async {
             bool? result= await showDialog<bool>(
               context: context,
               builder: (c) => AlertDialog(
                 title: Text('Warning',style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                 content: Text('Do you really want to exit ?',style: TextStyle(fontSize: 13.sp,)),
                 actions: [
                   TextButton(
                     child: Text('Yes',style: TextStyle(fontSize: 11.sp,)),
                     onPressed: () => Navigator.pop(c, true),
                   ),
                   TextButton(
                     child: Text('No',style: TextStyle(fontSize: 11.sp,)),
                     onPressed: () => Navigator.pop(c, false),
                   ),
                 ],
               ),
             );
             if(result == null){
               result = false;
             }
             return result;
           },
           child: AnnotatedRegion<SystemUiOverlayStyle>(
             value: SystemUiOverlayStyle(
               statusBarColor: Colors.transparent,
               statusBarIconBrightness:  Brightness.light,
             ),
             child: Scaffold(
               body: Container(
                 child: ClipRRect(
                   child: Stack(
                     alignment: Alignment.center,
                     children: [
                       /*
                       Container(
                         height: 100.h,
                         decoration: BoxDecoration(
                             image: const DecorationImage(fit: BoxFit.cover,image:
                             const AssetImage('Assets/images/hh.jpg'),)),),

                        */
                       Container(
                         height: 100.h,
                         /*
                         child: Card(
                           elevation: 8,
                           color: Colors.grey,
                           shadowColor: Colors.grey,
                           margin: EdgeInsets.only(bottom: 0),
                           clipBehavior: Clip.antiAliasWithSaveLayer,
                           child: CachedNetworkImage(
                             imageUrl: 'https://images.unsplash.com/photo-1525164286253-04e68b9d94c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                             imageBuilder: (context, imageProvider) => Container(
                               decoration: BoxDecoration(
                                 image: DecorationImage(
                                     image: imageProvider,fit: BoxFit.cover),
                               ),
                             ),
                             placeholder: (context, url) => Center(
                               child: Shimmer.fromColors(
                                 baseColor: Colors.grey[200]!,
                                 highlightColor: Colors.grey[100]!,
                                 child: Container(
                                   height: 100.h,
                                   color: Colors.grey[700],
                                 ),
                               ),
                             ),
                             errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                           ),
                         ),

                          */
                         decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover,image:AssetImage('Assets/images/splash.jpg',) ))
                       ),
                       Padding(
                         padding:  EdgeInsets.only(bottom:  5.h),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                   width: 19.h,      //It will take a 30% of screen height
                                   height: 19.h,
                                   decoration: BoxDecoration(
                                       image: const DecorationImage(fit: BoxFit.cover,image:
                                       const AssetImage('Assets/images/logo.png'),)),),
                                 SizedBox(width: 13,),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                   ],
                                 ),
                               ],
                             ),
                             SizedBox(height: 20,),
                     //      Container(height: 4.h,width:4.h ,child: CircularProgressIndicator(color: Colors.white,)),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
         );

   }
 }
