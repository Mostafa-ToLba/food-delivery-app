
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_eat/foodLayout/foodLayoutScreen.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class OrderDoneScreen extends StatelessWidget {
   const OrderDoneScreen({Key? key}) : super(key: key);

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
                         image: DecorationImage(fit: BoxFit.cover,image:
                         AssetImage('Assets/images/hh.jpg'),)),),

                    */
                   Container(
                     height: 100.h,
                     child: CachedNetworkImage(
                       imageUrl: 'https://firebasestorage.googleapis.com/v0/b/easy-eat-5dd80.appspot.com/o/splashScreen.jpg?alt=media&token=e314d75d-2b66-4461-bb94-91928a9a6ba7',
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
                   Padding(
                     padding:  EdgeInsets.symmetric(horizontal: 3.h),
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadiusDirectional.all(Radius.circular(20.sp)),
                          ),
                       height: 75.h,
                       width: 75.h,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children:
                         [
                           SizedBox(height: 2.h,),
                           Container(
                             alignment: Alignment.center,
                             height: 20.h,
                             child: Lottie.asset('Assets/animation/done.json',),
                           ),
          //                 Icon(Icons.done,color: HexColor('#184a2c'),size: 100,),
                           SizedBox(height: 1.5.h,),
                           Text('Order Successfully',style: TextStyle(color: HexColor('#7a0000'),fontSize: 22.sp,),textAlign: TextAlign.center),
                           Text('Placed.',style: TextStyle(color: HexColor('#7a0000'),fontSize: 22.sp),textAlign: TextAlign.center),
                           SizedBox(height: 3.h,),

                           Text('تم ارسال الطلب الخاص بك -',style: TextStyle(color: HexColor('#7a0000'),fontSize: 16.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
                           Text('سيصلك رساله عند قبول الطلب',style: TextStyle(color: HexColor('#7a0000'),fontSize: 16.sp,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
                        //   Text('وسيصلك اشعار عند قبول الطلب',style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                       //    Text('.. من المطعم',style: TextStyle(color: Colors.black,fontSize: 17.sp),),
                           SizedBox(height: 5.h,),
                           //Just wait delivery arrive at home
                           //about 45 minutes to deliver
                           Container(
                             width: 73.w,
                             height: 7.h,
                             decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),color: HexColor('#7a0000')),
                             child: TextButton(
                               style: ButtonStyle(
                                 splashFactory: NoSplash.splashFactory,
                               ),
                               onPressed: ()
                             {
                               NavigateAndFinsh(context, FoodLayoutScreen());
                             }
                               ,child: Text('Continue Shopping',style: TextStyle(color: Colors.white,fontSize: 13.sp),),),
                           ),
                         ],
                       ),
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
