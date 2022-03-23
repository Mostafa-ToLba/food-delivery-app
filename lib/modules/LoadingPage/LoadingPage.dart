
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/modules/orderDoneScreen/odrderDoneScreen.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class LoadingPage extends StatelessWidget {
   const LoadingPage({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return WillPopScope(
       onWillPop: () async => false,
       child: BlocConsumer<FoodCubit,FoodCubitStates>(
         listener: (BuildContext context, state) {
           if(state is myOrdersDoneState)
             NavigateAndFinsh(context, OrderDoneScreen());
         },
         builder: (BuildContext context, Object? state) {
           return Scaffold(
             appBar: AppBar(leading: Text(''),),
             body: Center(
               child: Container(
                 color: Colors.white,
                 child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Shimmer.fromColors(
                         baseColor: Colors.black,
                         direction: ShimmerDirection.ltr,
                         highlightColor: Colors.red,
                         child: Text(
                           '....جاري ارسال الطلب',
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             fontSize: 22.sp,
                             fontWeight:
                             FontWeight.bold,
                           ),
                         ),
                       ),
                       //          Text('....من فضلك انتظر',style: TextStyle(fontSize: 18.sp),),
                       SizedBox(height: 3.h,),
                       Container(width: 80.w,height: 1.h,child: LinearProgressIndicator(backgroundColor: Colors.grey[300],))
                     ]
                 ),
               ),
             ),
           );
         },
       ),
     );
   }
 }
