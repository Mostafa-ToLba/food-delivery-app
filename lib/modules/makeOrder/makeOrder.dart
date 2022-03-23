

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/models/registerModel/registemModel.dart';
import 'package:easy_eat/modules/orderDoneScreen/odrderDoneScreen.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class MakeOrder extends StatelessWidget {
  var totalPrice;

    MakeOrder(this.totalPrice, {Key? key}) : super(key: key);
   var LocationController = TextEditingController();
    var NameController = TextEditingController();
    var PhoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
   @override
   Widget build(BuildContext context) {

     return Builder(
       builder: (context) {
         FoodCubit.get(context).GetUserInformationFunction();
         return BlocConsumer<FoodCubit,FoodCubitStates>(
           listener: (BuildContext context, state) {  },
           builder: (BuildContext context, Object? state) {
             if(FoodCubit.get(context).getUserInformation.location==''&&FoodCubit.get(context).getUserInformation.name==''&&FoodCubit.get(context).getUserInformation.phone=='')
               {
                 LocationController.text=LocationController.text;
                 NameController.text=NameController.text;
                 PhoneController.text=PhoneController.text;
               }
             else
               {
                 LocationController.text=FoodCubit.get(context).getUserInformation.location!;
                 NameController.text=FoodCubit.get(context).getUserInformation.name!;
                 PhoneController.text=FoodCubit.get(context).getUserInformation.phone!;
               }
             return Scaffold(
               appBar: AppBar(
              leadingWidth: 15.w,
              toolbarHeight: 8.h,
                 title: Text('اكمال الدفع',style: TextStyle(fontSize: 18.sp),),
                 leading:IconButton(iconSize: 16.sp,icon: Icon(IconBroken.Arrow___Left_2,size: 16.sp,), onPressed: ()
                 {
                   Navigator.pop(context);
                 },) ,
               ),
               body: SingleChildScrollView(
                 child: Padding(
                   padding:  EdgeInsets.only(right: 2.h,left: 2.h,bottom: 2.h),
                   child: Form(
                     key: formKey ,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children:
                       [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('الطلب الخاص بك من',style: TextStyle(fontSize: 12.sp)),
                             Text('قصر الشام',style: TextStyle(fontSize: 20.sp,color: HexColor('#7a0000')),),
                             Row(
                               children: [
                                 Text('هيوصلك في خلال 45 دقيقة',style: TextStyle(fontSize:12.sp ),),
                                 Container(height: 12.h,width: 15.h,child: Lottie.asset('Assets/animation/moto.json'),)
                               ],
                             ),

                           ],
                         ),
                         Text('عنوان التوصيل',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold),),
                         SizedBox(height: .5.h,),
                         SingleChildScrollView(
                           scrollDirection: Axis.vertical,
                           physics: ScrollPhysics(),

                           child: TextFormField(textAlign: TextAlign.start,
                             maxLines: 12,
                             minLines: 1,
                             style: TextStyle(color: Colors.black,fontSize: 13.sp,overflow: TextOverflow.ellipsis),
                             cursorColor: Colors.blue,
                             autofocus: false,
                             controller: LocationController,
                             decoration:
                             InputDecoration(
                               prefixIcon: Icon(
                                 IconBroken.Location,
                                 color: Colors.grey,size: 18.5.sp,
                               ),
                                 hintStyle: TextStyle(color: Colors.grey),
                                 focusColor: Colors.blue,
                                 fillColor: Colors.blue,
                                 contentPadding: EdgeInsets.all(5.sp),
                                 hintText: ' ادخل العنوان بالتفصيل',
                                 border:OutlineInputBorder(),
                             ),
                             validator: (value)
                             {
                               if(value!.isEmpty)
                               {
                                 return'من فضلك ادخل العنوان الخاص بك';
                               }
                             },
                           ),
                         ),
                    //     SizedBox(height: 1.h,),
                         SizedBox(height: 2.h,),
                         Text('الاسم',style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold),),
                         defultformfield(
                           textStyle: TextStyle(fontSize: 13.sp),
                           suffixPressed: ()
                           {
                           },
                           controle: NameController,
                           keyboard: TextInputType.name,
                           prefix: IconBroken.User,
                           label: 'الاسم',
                           validate:(value)
                           {
                             if(value.isEmpty)
                             {
                               return'من فضلك ادخل الاسم ';
                             }
                           },
                         ),
                         SizedBox(height: 2.h,),
                         Text('رقم الموبايل/ الرقم الارضي ',style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold),),

                         SizedBox(height: 1.2.h,),
                         defultformfield(
                           textStyle: TextStyle(fontSize: 13.sp),
                           suffixPressed: ()
                           {
                           },
                           controle: PhoneController,
                           keyboard: TextInputType.phone,
                           prefix: IconBroken.Call,
                           label: 'يمكنك كتابه اكتر من رقم',
                           validate:(value)
                           {
                             if(value.isEmpty)
                             {
                               return'من فضلك ادخل رقم الموبايل';
                             }
                           },
                         ),
                         SizedBox(height: 1.h,),
                         Text('طريقه الدفع',style: TextStyle(fontSize: 15.sp),),
                         SizedBox(height:1.h,),
                         Container(
                           height: 7.h,
                           width: double.infinity,
                           child: Padding(
                             padding:  EdgeInsets.only(left: 1.h),
                             child: Row(
                               children: [
                                 Container(
                                   height: 3.h,
                                   width: 3.h,
                                   child: ClipRRect(
                                     clipBehavior: Clip.hardEdge,
                                     borderRadius: BorderRadius.all(Radius.circular(5)),
                                     child: SizedBox(
                                       width: Checkbox.width,
                                       height: Checkbox.width,
                                       child: Container(
                                         decoration: new BoxDecoration(
                                           border: Border.all(
                                             width: 3,
                                           ),
                                           borderRadius: new BorderRadius.circular(5),
                                           color: Colors.white,
                                         ),
                                         child: Theme(
                                           data: ThemeData(
                                             unselectedWidgetColor: Colors.transparent,
                                           ),
                                           child: Checkbox(
                                             value: true,
                                             activeColor: Colors.transparent,
                                             checkColor: HexColor('#8d2422'),
                                             materialTapTargetSize: MaterialTapTargetSize.padded, onChanged: (bool? value) { },
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 1.h,),
                                 Text('كاش',style: TextStyle(fontSize: 14.sp),),
                                 SizedBox(width: 2.h,),
                               ],
                             ),
                           ),
                           color: HexColor('#f5f6f7'),
                         ),
                         SizedBox(height: 3.h,),
                         Container(
                       width: 100.w,
                       height: 7.h,
                       decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),color: HexColor('#7a0000')),
                       child: MaterialButton(
                         color: HexColor('#7a0000'),
                         onPressed: () {
                           if (formKey.currentState!.validate()) {
                             FoodCubit.get(context).updateInformation(name: NameController.text,phone: PhoneController.text,location: LocationController.text);
                             FoodCubit.get(context).sameTimeMakingOrder().then((value)
                             {
                               if(FoodCubit.get(context).sameTime==true)
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("انتظر لحظات حتي يتم قبول الطلب السابق ثم حاول الطلب مره اخري",style: TextStyle(fontSize: 13.sp
                                 ),)));
                               if(FoodCubit.get(context).sameTime==false)
                                 FoodCubit.get(context).showAlertDialog(context,
                                     LocationController: LocationController.text
                                         .toString(),
                                     NameController: NameController.text
                                         .toString(),
                                     PhoneController: PhoneController.text
                                         .toString(), total: totalPrice.round());
                             });
                           }
                         },
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text('اطلب',style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                             SizedBox(width: 8.sp,),
                             Padding(
                               padding: const EdgeInsets.only(bottom: 6),
                               child: Icon(Icons.done,color: Colors.white,size: 20.sp,),
                             ),
                           ],
                         ),),
                     ),
                       ],
                     ),
                   ),
                 ),
               ),
             );
           },
         );
       }
     );
   }
 }
