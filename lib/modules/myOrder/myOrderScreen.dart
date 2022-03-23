import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder <QuerySnapshot>(
        stream: FoodCubit.get(context).haveOrder(),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData||snapshot.data!.size==0)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
                Center(child: Icon(IconBroken.Document,size: 20.h,color: HexColor('#7a0000'),)),
                Center(child: Text('لا توجد طلبات متاحه',style: TextStyle(fontSize: 25.sp),)),
                Center(child: Text('قم بشراء شئ وتتبع طلبك هنا',style: TextStyle(fontSize: 15.sp,color: Colors.grey))),
              ],
            );
          else
          {
            for(var doc in snapshot.data!.docs)
            {
              if(doc.id==FirebaseAuth.instance.currentUser?.uid)
                return SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.all(40.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Row(
                          children: [
                            CircleAvatar(radius: 15.sp,backgroundColor: Colors.blue,child: Text('1',style: TextStyle(color: Colors.white,fontSize:15.sp ),),),
                            SizedBox(width: 10.sp,),
                            SizedBox(width: 3.w,),
                            Column(
                              children: [
                                Text('استلام الطلب',style: TextStyle(fontSize: 16.sp,color: Colors.blue),),
                                Text('تم استلام الطلب الخاص بك',style: TextStyle(fontSize: 12.sp,color: Colors.blue),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 3.sp,),
                        Padding(
                          padding:  EdgeInsets.all(13.sp),
                          child: Container(height: 95.sp,width: 1.sp,color:doc['confirmOrder']==false?Colors.grey:Colors.blue,),
                        ),
                        Row(
                          children: [
                            CircleAvatar(radius: 15.sp,backgroundColor:doc['confirmOrder']==false?Colors.grey:Colors.blue,child: Text('2',style: TextStyle(color: Colors.white,fontSize:15.sp),),),
                            SizedBox(width: 10.sp,),
                            SizedBox(width: 3.w,),
                            Column(
                              children: [
                                Text('قبول الطلب',style: TextStyle(fontSize: 16.sp,color: doc['confirmOrder']==false?Colors.grey:Colors.blue)),
                                Text('يتم الان تحضير الطعام',style: TextStyle(fontSize: 12.sp,color: doc['confirmOrder']==false?Colors.grey:Colors.blue)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 2.sp,),
                        Padding(
                          padding:  EdgeInsets.all(13.sp),
                          child: Container(height: 95.sp,width: 1.sp,color: doc['sendOrder']==false?Colors.grey:Colors.blue,),
                        ),
                        Row(
                          children: [
                            CircleAvatar(radius: 15.sp,backgroundColor:doc['sendOrder']==false?Colors.grey:Colors.blue,child: Text('3',style: TextStyle(color: Colors.white,fontSize:15.sp),),),
                            SizedBox(width: 10.sp,),
                            SizedBox(width: 3.w,),
                            Column(
                              children: [
                                Text('ارسال الطلب',style: TextStyle(fontSize: 16.sp,color:doc['sendOrder']==false?Colors.grey:Colors.blue)),
                                Text('الدليفري في الطريق اليك',style: TextStyle(fontSize: 12.sp ,color: doc['sendOrder']==false?Colors.grey:Colors.blue)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              else if(doc.id!=FirebaseAuth.instance.currentUser?.uid)
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    Center(child: Icon(IconBroken.Document,size: 20.h,color: HexColor('#7a0000'),)),
                    Center(child: Text('لا توجد طلبات متاحه',style: TextStyle(fontSize: 25.sp),)),
                    Center(child: Text('قم بشراء شئ وتتبع طلبك هنا',style: TextStyle(fontSize: 15.sp))),
                  ],
                );
            }
          }
          return Text('',style: TextStyle(color: Colors.white),);
        },
      ),
    );
  }
}
