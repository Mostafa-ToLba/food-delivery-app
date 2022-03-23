
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/models/addToCartModel/addToCartModel.dart';
import 'package:easy_eat/modules/CartScreen/cartScreen.dart';
import 'package:easy_eat/modules/oPenDescriptionPhoto/photoOpen.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

class ItemDescription extends StatelessWidget {
  String name;
  String image;
  int price;
  String description;
  int a;
  var TextController =TextEditingController();
  bool availability;
    ItemDescription( this.name, this.price,  this.image, this.description,  this.a, this.availability, {Key? key}) : super(key: key);
   @override
   Widget build(BuildContext context) {
             return WillPopScope(
               onWillPop: () async{
                 int result= FoodCubit.get(context).number=1;
                 if(result != 1){
                   result = 1;
                 }
                 return true;
               },
               child: BlocConsumer<FoodCubit,FoodCubitStates>(
                 listener: (BuildContext context, state) {},
                 builder: (BuildContext context, Object? state) {
                   return AnnotatedRegion(
                     value: SystemUiOverlayStyle(
                       statusBarIconBrightness: Brightness.light,
                       statusBarColor: Colors.transparent,
                     ),
                     child: Scaffold(
                       body: SingleChildScrollView(
                         child: Column(
                           children: [
                             ClipRRect(
                               borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0),bottomRight:Radius.circular(0) ),
                               child:  ClipPath(
                                 child:Container(
                                   height: 50.h,
                                   child: Stack(
                                     children: [
                                       Stack(
                                         alignment: AlignmentDirectional.bottomCenter,
                                         children: [
                                           Align(
                                             alignment: AlignmentDirectional.topCenter,
                                             child: InkWell(
                                               onTap: ()
                                               {
                                               },
                                               child: Container(
                                                 height: 40.h,
                                                 decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10) ),
                                                     image: DecorationImage(image: AssetImage('Assets/images/logo.jpg'),
                                                       fit: BoxFit.fill,
                                                     )
                                                 ),
                                               ),
                                             ),
                                           ),
                                           InkWell(
                                             onTap: ()
                                             {
                                               NavigateTo(context, PhotoOpen(image));
                                             },
                                             child: CircleAvatar(
                                               radius: 12.1.h,backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                               child: CircleAvatar(
                                                 backgroundImage: NetworkImage('${image}',),
                                                 radius: 11.8.h,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                       Padding(
                                           padding:  EdgeInsets.all(4.h),
                                           child: CircleAvatar(radius: 16.sp,backgroundColor: Colors.white,
                                             child: IconButton(iconSize: 23.sp,padding: EdgeInsetsDirectional.zero,icon: Icon(IconBroken.Arrow___Left_2,color: HexColor('#8d2422'),size: 15.sp,),
                                               onPressed: (){
                                               FoodCubit.get(context).number=1;
                                                 Navigator.pop(context);
                                               },),)),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding:  EdgeInsets.only(top: 0,left: 2.h,right: 2.h),
                               child: Column(
                                 children: [
                                   Text('${name}',textAlign:TextAlign.center ,
                                     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19.sp,color: HexColor('#8d2422')),),
                                   Text('${description}',textAlign: TextAlign.center,
                                     style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13.sp,color: Colors.grey,),),
                                   SizedBox(height: 1.h,),
                                   Row(
                                     mainAxisAlignment:MainAxisAlignment.start,
                                     children: [
                                       Container(
                                         child: IconButton(splashRadius: 1,splashColor: Colors.white,icon: Icon(MdiIcons.minus,color: Colors.black,size: 18.sp), onPressed: ()
                                         {
                                           if(FoodCubit.get(context).number>1)
                                           {
                                             FoodCubit.get(context).Minus();
                                             price = price-a;
                                           }
                                         },),
                                         height: 7.3.h,
                                         width: 7.3.h,
                                         decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.all(Radius.circular(15)),color: HexColor('#ffebed')),
                                       ),
                                       SizedBox(width: 2.5.w,),
                                       Text('${FoodCubit.get(context).number}',style: TextStyle(fontSize: 20.sp,color: Colors.black),),
                                       SizedBox(width: 2.5.w),
                                       Container(
                                         child: IconButton(splashRadius: 1,splashColor: Colors.white,icon: Icon(MdiIcons.plus,color: Colors.black,size: 18.sp), onPressed: ()
                                         {
                                           FoodCubit.get(context).Plus();
                                          price = price+a;
                                         },),
                                         height: 7.3.h,
                                         width: 7.3.h,
                                         decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.all(Radius.circular(15)),color: HexColor('#ffebed')),
                                       ),
                                       Spacer(),
                                       Text('${price} ج.م',style: TextStyle(color: HexColor('#8d2422'),fontSize: 18.sp),),
                                     ],
                                   ),
                                   SizedBox(height: 2.h,),
                                   Container(
                                     height: 5.5.h,
                                     width: double.infinity,
                                     child: Padding(
                                       padding:  EdgeInsets.only(left: 1.2.h,top: .5.h,bottom:.6.h ),
                                       child: Text('اضافات خاصه',style: TextStyle(fontSize: 15.sp),),
                                     ),
                                     color: HexColor('#f5f6f7'),
                                   ),
                                   SizedBox(height: 1.h,),
                                   SingleChildScrollView(
                                     scrollDirection: Axis.vertical,
                                     physics: ScrollPhysics(),
                                     child: TextFormField(
                                       maxLines: 10,
                                       minLines: 1,
                                       style: TextStyle(color: Colors.black,fontSize: 12.sp),
                                       cursorColor: Colors.blue,
                                       autofocus: false,
                                       controller: TextController,
                                       decoration:
                                       InputDecoration(
                                           hintStyle: TextStyle(color: Colors.grey,fontSize:12.sp ),
                                           focusColor: Colors.blue,
                                           fillColor: Colors.blue,
                                           contentPadding: EdgeInsets.all( 5.sp),
                                           hintText: 'مثال. من فضلك عايز البروست حار',
                                       //    border:InputBorder.none
                                         border:OutlineInputBorder(),
                                       ),
                                     ),
                                   ),
                                   SizedBox(height: 2.h,),
                                   if(availability==true)
                                   Container(
                                       width: 100.w,
                                       height: 7.h,
                                       decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),color: HexColor('#8d2422')),
                                       child: MaterialButton(
                                         color: HexColor('#7a0000'),
                                         /*
                                         style: ButtonStyle(
                                           splashFactory: NoSplash.splashFactory,
                                         ),

                                          */
                                         onPressed: ()
                                       {
                                         if(FirebaseAuth.instance.currentUser==null)
                                           FoodCubit.get(context).ShowDialogForLogin(context);
                                   //        defaultToast(context: context,message: 'قم بتسجيل الدخول حتي تسطيع الطلب ',color: Colors.black);
                                         FoodCubit.get(context).addToCartFunction(name: name,price: price,num:FoodCubit.get(context).number,text: TextController.text);
                                         if(FirebaseAuth.instance.currentUser!=null)
                                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration:Duration(seconds: 1) ,content: Text("تمت الاضافه الي سلة التسوق",style: TextStyle(fontSize: 14.sp),)));
                                         TextController.clear();
                                       }
                                         ,child: Text('ضيف لسلة التسوق',style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.bold),),)
                                   ),
                                   SizedBox(height:2.h,),
                                 ],
                               ),
                             ),

                           ],
                         ),
                       ),
                     ),
                   );
                 },
               ),
             );
 }
}

