
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_eat/foodLayout/foodLayoutScreen.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/models/addToCartModel/addToCartModel.dart';
import 'package:easy_eat/modules/itemDescription/itemDescription.dart';
import 'package:easy_eat/modules/makeOrder/makeOrder.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

 class CartScreen extends StatelessWidget {
  CartScreen();
   @override
   Widget build(BuildContext context) {
     return Builder(
       builder: (BuildContext context) {
         FoodCubit.get(context).getDelivery();
       FoodCubit.get(context).totalPrice();
       FoodCubit.get(context).getCart2();
      //   FoodCubit.get(context).getDiscount();
         FoodCubit.get(context).getDiscount0();
         FoodCubit.get(context).getDiscount2();
         return BlocConsumer<FoodCubit,FoodCubitStates>(
           listener: (BuildContext context, state) {},
           builder: (BuildContext context, Object? state) {
          //   double afterDiscount =FoodCubit.get(context).Total+FoodCubit.get(context).delivary;
             return Scaffold(
               appBar: AppBar(
                 toolbarHeight: 10.h,
                 leading:Text('') ,
                 title:  Padding(
                   padding:  EdgeInsets.only(left: 3.h,right: 3.h),
                   child: Text('سلة التسوق',style: TextStyle(fontSize: 18.sp),),
                 ),
                 actions:
                 [
                   Padding(
                     padding:  EdgeInsets.only(right: 4.h),
                     child: Container(
                       height:8.h ,
                       width:8.h ,
                       child: Lottie.asset('Assets/animation/shoppingcart.json',),
                     ),
                   ),
                 ],
               ),
               body: SingleChildScrollView(
                 child: Padding(
                   padding:  EdgeInsets.only(left: 2.h,right:2.h ,bottom: 2.h),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       if(FoodCubit.get(context).GetCartList.length>0)
                       ConditionalBuilder(
                         condition: FoodCubit.get(context).GetCartList.length>0,
                         builder: (BuildContext context)
                         {
                            if(state is deleteItemCartLoadingState)
                           {
                             return Center(child: CircularProgressIndicator());
                           }
                           else  (FoodCubit.get(context).GetCartList.length>0);
                             return ListView.separated(
                                 physics: NeverScrollableScrollPhysics(),
                                 shrinkWrap: true,
                                 itemBuilder: (context,index)=>Item(FoodCubit.get(context).GetCartList[index],FoodCubit.get(context).Ids[index],context),
                                 separatorBuilder: (context,index)=>SizedBox(height: .2.h,),
                                 itemCount: FoodCubit.get(context).GetCartList.length);

                         },
                         fallback: (BuildContext context)=>
                             Center(child: Text('')),
                       ),
                       if(FoodCubit.get(context).GetCartList.length<=0)
                         ConditionalBuilder(
                             condition: FoodCubit.get(context).GetCartList.length<=0,
                             builder: (context)=>noItem(),
                             fallback: (context)=>Center(child: CircularProgressIndicator())),
                       SizedBox(height: .3.h,),
                       SizedBox(height: 5.h,),
                       Row(
                         children: [
                           Text('خدمه التوصيل',style: TextStyle(fontSize: 14.sp,color: Colors.grey),),
                           Spacer(),
                           StreamBuilder <QuerySnapshot>(
                             stream: FoodCubit.get(context).delivaryService(),
                             builder: (context, snapshot)
                             {
                               if(!snapshot.hasData||snapshot.data!.size==0)
                                 return Center(child: Text('',style: TextStyle(fontSize: 19.sp),));
                               else
                               {
                                 for(var doc in snapshot.data!.docs)
                                 {
                                FoodCubit.get(context).delivary=doc['delivaryService'];
                                if(doc['delivaryService']==0)
                                  return Text('free',style: TextStyle(fontSize: 14.sp,color: Colors.grey),);
                                  else
                                    return Text(FoodCubit.get(context).GetCartList.length>0?'${doc['delivaryService']} ج.م':'0 ج.م',style: TextStyle(fontSize: 15.sp,color: Colors.grey));
                                 }
                               }
                               return Text('',style: TextStyle(color: Colors.white),);
                             },
                           ),
                         ],
                       ),
                       SizedBox(height: 1.5.h,),
                       Row(
                         children: [
                           Text('الاجمالي',style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                           Spacer(),
                           Text(FoodCubit.get(context).GetCartList.length>0?'${FoodCubit.get(context).Total+FoodCubit.get(context).delivary} ج.م':'0 ج.م',style: TextStyle(fontSize: 15.sp,color: Colors.black)),
                         ],
                       ),
                       SizedBox(height: 1.5.h,),
                       if(FoodCubit.get(context).a>0)
                       Row(
                         children: [
                           Text('الاجمالي بعد الخصم',style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                           Spacer(),
                           Text(FoodCubit.get(context).GetCartList.length>0?'${(FoodCubit.get(context).Total-(FoodCubit.get(context).a*FoodCubit.get(context).Total).round())+FoodCubit.get(context).delivary} ج.م':'0 ج.م',style: TextStyle(fontSize: 15.sp,color: Colors.black)),
                         ],
                       ),
                       SizedBox(height: 4.h,),
                       Container(
                           width: 80.w,
                           height: 7.h,
                           decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.h)),color: HexColor('#7a0000')),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Expanded(
                                 child: Container(
                                   color: HexColor('#7a0000'),
                                   height: 7.h,
                                   width: 80.w,
                                   child: MaterialButton(
                                     splashColor: HexColor('#7a0000'),
                                        /*
                                     style: ButtonStyle(
                                       splashFactory: NoSplash.splashFactory,
                                     ),

                                      */
                                     color: HexColor('#7a0000'),
                                     onPressed: ()
                                   {
                                     if(FoodCubit.get(context).GetCartList.length>0)
                                     FoodCubit.get(context).EkmalEldf3showAlertDialog(context);
                      //              NavigateTo(context, MakeOrder(FoodCubit.get(context).Total+10));
                                     else
                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("سلة التسوق فارغة",style: TextStyle(fontSize: 15.sp),)));
                                   }
                                     ,child: Text('اكمال الدفع' ,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.bold),),),
                                 ),
                               ),
                               InkWell(
                                 child: Container(padding: EdgeInsets.all(0),
                                   child: Center(child: Text(FoodCubit.get(context).GetCartList.length>0?'${(FoodCubit.get(context).Total-(FoodCubit.get(context).a*FoodCubit.get(context).Total).round())+FoodCubit.get(context).delivary} ج.م':'0',textAlign: TextAlign.center,style: TextStyle(color:HexColor('#7a0000'),fontSize: 14.sp,fontWeight: FontWeight.bold,),)),
                                   height: 5.h,
                                   width: 25.w,
                                   decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadiusDirectional.all(Radius.circular(4.h))),
                                 ),
                                 onTap: ()
                                 {
                                   if(FoodCubit.get(context).GetCartList.length>0)
                                     FoodCubit.get(context).EkmalEldf3showAlertDialog(context);
                                   //              NavigateTo(context, MakeOrder(FoodCubit.get(context).Total+10));
                                   else
                                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("سلة التسوق فارغة",style: TextStyle(fontSize: 15.sp),)));
                                 },
                               ),
                               SizedBox(width: 1.h,),
                             ],
                           )
                       ),
                     ],
                   ),
                 ),
               ),
             );
           },
         );
       },
     );
   }
}
 Widget Item(AddToCart cartList, String id,context)=>Dismissible(
   background: Container(color: Colors.white,child: Padding(
     padding:  EdgeInsets.only(left: 35.w),
     child: Icon(Icons.delete,size: 5.h,color: HexColor('#7A0000'),),
   ),),
   key: Key(id.toString()),
   onDismissed: (direction){
     FoodCubit.get(context).deleteOrder(id);
     },
   child: Container(
     child: Padding(
       padding:  EdgeInsets.all(2.h),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             children: [
               Text('${cartList.num}x',style: TextStyle(fontSize: 15.sp,color: HexColor('#8d2422')),),
               SizedBox(width: 4.w,),
               Expanded(child: Text('${cartList.name}',style: TextStyle(fontSize: 15.sp,color: HexColor('#8d2422')),)),
               Spacer(),
               Text('${cartList.price} ج.م',style: TextStyle(fontSize: 15.sp,color: HexColor('#8d2422')),),
               SizedBox(width: 2.w,),
               CircleAvatar(
                 radius: 15.sp,
                 backgroundColor: Colors.white,
                 child: IconButton(iconSize:16.sp ,padding: EdgeInsetsDirectional.zero,onPressed:()
                 {
                   FoodCubit.get(context).deleteOrder(id);
                 }, icon: Icon(Icons.close,size: 15.sp,) ,),
               ),
             ],
           ),
           SizedBox(height: .2.h,),
           Text('${cartList.text}',style: TextStyle(fontSize: 12.sp),),
         ],
       ),
     ),
   //  height: 18.h,
     width: double.infinity,
     color: HexColor('#ffebed'),
   ),
 );
 Widget noItem()=>Column(
   mainAxisAlignment: MainAxisAlignment.center,
   children: [
     Container(height: 25.h,child: Lottie.asset('Assets/animation/mobile.json',fit: BoxFit.fill)),
     SizedBox(height: .5.h,),
     Center(child: Text('!سلة التسوق فارغة',style: TextStyle(fontSize: 20.sp,color: Colors.black),)),
     Center(child: Text('المنتجات المضافه الي السله سوف تظهر هنا',style: TextStyle(fontSize: 14.sp,color: Colors.grey),)),
   ],
 );


