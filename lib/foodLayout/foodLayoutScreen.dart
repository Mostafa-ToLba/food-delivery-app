
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/modules/CartScreen/cartScreen.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

class FoodLayoutScreen extends StatelessWidget {
    FoodLayoutScreen({Key? key}) : super(key: key);
   @override
   Widget build(BuildContext context) {
         return WillPopScope(
           child: BlocProvider(
             create: (BuildContext context)=>FoodCubit(InitialFoodState()),
             child: BlocConsumer<FoodCubit,FoodCubitStates>(
               listener: (BuildContext context, state) {},
               builder: (BuildContext context, Object? state) {
                 return AnnotatedRegion<SystemUiOverlayStyle>(
                     value: SystemUiOverlayStyle(
                     statusBarIconBrightness: Brightness.light,
                     statusBarColor: Colors.transparent,
                     ),
                   child: Scaffold(

                     appBar: AppBar(
                       toolbarHeight: 7.5.h,
                       leadingWidth: 0,
                       leading: Text(''),
                       actions: [
                         Row(
                           children: [
                             Stack(
                               alignment: AlignmentDirectional.topEnd,
                               children: [
                                 CircleAvatar(backgroundColor:HexColor('#7a0000'),radius: 15.sp,child: IconButton(padding: EdgeInsets.zero,color: Colors.white,iconSize:18.5.sp, icon: Icon(IconBroken.Buy,size: 18.5.sp,), onPressed: ()
                                 {
                                   FoodCubit.get(context).ChangeBottomNavItem(1,context);
                                 },),),
                                 CircleAvatar(backgroundColor: Colors.red,radius: 7.7.sp,child: StreamBuilder <QuerySnapshot>(
                                   stream: FoodCubit.get(context).getNumberOfItem2(),
                                   builder: (context, snapshot)
                                   {
                                     if(!snapshot.hasData||snapshot.data!.size==0)
                                       return Center(child: Text('0',style: TextStyle(color: Colors.white,fontSize:12.5.sp ),));
                                     else
                                     {
                                         return Text('${snapshot.data!.docs.length}',style: TextStyle(color: Colors.white,fontSize: 12.5.sp),);
                                     }
                                     return Text('',style: TextStyle(color: Colors.white),);
                                   },
                                 ),),
                               ],
                             ),
                             SizedBox(width: 3.5.w,),
                           ],
                         ),
                       ],
                     title: Row(
                       children: [
                         InkWell(
                           child: CircleAvatar(radius: 15.3.sp,
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
                                     else if(doc.id==FirebaseAuth.instance.currentUser?.uid)
                                       return Center(child: Text('',style: TextStyle(fontSize: 20.sp),));
                                   }
                                 }
                                 return Text('',style: TextStyle(color: Colors.white),);
                               },
                             ),
                            ),
                           onTap: ()
                           {
                             FoodCubit.get(context).ChangeBottomNavItem(3, context);
                           },
                         ),
                         SizedBox(width: 4.w,),
                     //    backgroundImage: NetworkImage('https://image.freepik.com/free-photo/front-view-young-female-courier-female-worker-food-delivery-service-holding-pizza-boxes-food-packages-white_140725-20187.jpg'),
                         StreamBuilder <QuerySnapshot>(
                           stream: FoodCubit.get(context).getstatusfromdata(),
                           builder: (context, snapshot)
                           {
                             if(!snapshot.hasData||snapshot.data!.size==0)
                               return Center(child: Text('',style: TextStyle(fontSize: 20.sp),));
                             else
                               {
                                 for(var doc in snapshot.data!.docs)
                                   return Row(
                                     children: [
                                       Text(doc['status']?'مفتوح الان':'مغلق الان',style: TextStyle(fontSize: 16.5.sp),),
                                       SizedBox(width: 3.5.w,),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 0),
                                         child: CircleAvatar( backgroundColor: doc['status']? Colors.green:Colors.red,radius:.8.h,),
                                       ),
                                     ],
                                   );
                               }
                               return Text('',style: TextStyle(color: Colors.white),);
                           },
                         ),
                       ],
                     ),
                     ),
                     body: FoodCubit.get(context).Screens[FoodCubit.get(context).currentIndex],
                     bottomNavigationBar: BottomNavigationBar(
                       onTap: (index)
                       {
                         FoodCubit.get(context).ChangeBottomNavItem(index, context);
                       },
                       currentIndex:FoodCubit.get(context).currentIndex ,
                       items:
                     [
                       BottomNavigationBarItem(icon: Icon(MdiIcons.silverwareForkKnife,size: 20.sp,),label: 'الرئيسية'),
                       BottomNavigationBarItem(icon: Icon(MdiIcons.cart,size: 20.sp,),label: 'سله التسوق'),
                       BottomNavigationBarItem(icon: Icon(MdiIcons.androidMessages,size: 20.sp,),label: 'طلبي'),
                       BottomNavigationBarItem(icon: Icon(MdiIcons.account,size: 20.sp,),label: 'حسابي'),
                     ],),
                   ),
                     );
               },
             ),
           ),
             onWillPop:() async {
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
         );
   }
 }


