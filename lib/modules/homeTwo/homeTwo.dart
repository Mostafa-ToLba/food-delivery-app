
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/models/checkenModel/checkenModel.dart';
import 'package:easy_eat/models/homeTwoModel/homeTwoModel.dart';
import 'package:easy_eat/modules/itemDescription/itemDescription.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeTwo extends StatelessWidget {
    HomeTwo({Key? key}) : super(key: key);
   var ListController = ScrollController();
   @override
   Widget build(BuildContext context) {
     return Builder(
       builder: (context) {
         FoodCubit.get(context).getNotify();
         return BlocConsumer<FoodCubit,FoodCubitStates>(
           listener: (BuildContext context, state) {  },
           builder: (BuildContext context, Object? state) {
             return Scaffold(
                 body:SingleChildScrollView(
                   physics: AlwaysScrollableScrollPhysics(),
                   child: Padding(
                     padding:  EdgeInsets.only(bottom: 1.2.h,right: 1.3.h,left: 1.3.h,top: .1.h),
                     child: Column(
                       children: [
                         StreamBuilder <QuerySnapshot>(
                           stream: FoodCubit.get(context).getUpdatefromdata(),
                           builder: (context, snapshot)
                           {
                             if(!snapshot.hasData||snapshot.data!.size==0)
                               return Center(child: Text('',style: TextStyle(fontSize: 20.sp),));
                             else
                             {
                               for(var doc in snapshot.data!.docs)
                                 if(doc['update']==true)
                                 return Container(
                                     padding: EdgeInsetsDirectional.all(2.h),
                                     decoration: BoxDecoration(
                                       border: Border.all(color: HexColor('#8d2422')),),
                                 //    height: 20.h,
                                     width:100.w,child: Center(child: Column(
                                   children: [
                                     Text('${doc['text1']}',textAlign: TextAlign.center,
                                       style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),
                                     ),
                                     Text('${doc['text2']} ',textAlign: TextAlign.center,
                                       style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),
                                     ),
                                     Text('${doc['text3']}',textAlign: TextAlign.center,
                                       style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),
                                     ),
                                   ],
                                 )));
                             }
                             return StreamBuilder <QuerySnapshot>(
                               stream: FoodCubit.get(context).getstatusfromdata(),
                               builder: (context, snapshot)
                               {
                                 if(!snapshot.hasData||snapshot.data!.size==0)
                                   return Center(child: Text('',style: TextStyle(fontSize: 20.sp),));
                                 else
                                 {
                                   for(var doc in snapshot.data!.docs)
                                     if(doc['status']==true)
                                     {
                                       if(SizerUtil.deviceType == DeviceType.mobile)
                                       return Container(
                                         height: 43.h,
                                         width: double.infinity,
                                         child: StreamBuilder <QuerySnapshot>(
                                           stream: FoodCubit.get(context).StreamgetSlider(),
                                           builder: (context, snapshot)
                                           {
                                             if(!snapshot.hasData||snapshot.data!.size==0)
                                               return Center(child: Text('',style: TextStyle(fontSize: 20.sp),));
                                             else
                                             {
                                                 return CarouselSlider.builder(
                                                     scrollPhysics: BouncingScrollPhysics(),
                                                     autoSliderDelay: Duration(seconds: 7),
                                                     enableAutoSlider: true,
                                                     unlimitedMode: true,
                                                     autoSliderTransitionCurve:
                                                     Curves.fastOutSlowIn,
                                                     autoSliderTransitionTime:  Duration(milliseconds: 160),
                                                     slideTransform: DefaultTransform(),
                                                     slideIndicator: CircularSlideIndicator(
                                                       indicatorBackgroundColor:
                                                       Colors.white,
                                                       currentIndicatorColor: Colors.black,
                                                       padding: EdgeInsets.only(bottom: 1.h),
                                                       indicatorRadius: 2.5.sp,
                                                     ),
                                                     slideBuilder: (index) {
                                                       QueryDocumentSnapshot<Object?>sliderImage = snapshot.data!.docs[index];
                                                       return Card(
                                                         elevation: 2,
                                                         color: Colors.grey,
                                                         shadowColor: Colors.grey,
                                                         margin: EdgeInsets.only(bottom: 2.5.sp),
                                                         clipBehavior: Clip.antiAliasWithSaveLayer,
                                                         child:  CachedNetworkImage(
                                               //            sliderImage['image'],
                                                           fit: BoxFit.cover,
                                                           imageUrl: sliderImage['image'],
                                                           placeholder: (context, url) => Center(
                                                             child: Shimmer.fromColors(
                                                               baseColor: Colors.grey[350]!,
                                                               highlightColor: Colors.grey[100]!,
                                                               child: Container(
                                                                 height: 45.h,
                                                                 color: Colors.grey[700],
                                                               ),
                                                             ),
                                                           ),
                                                           errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                                                         ),
                                                       );
                                                     },
                                                     itemCount: snapshot.data!.docs.length);

                                             }
                                           },
                                         ),
                                       );
                                       if(SizerUtil.deviceType == DeviceType.tablet)
                                         return Container(
                                           height: 55.h,
                                           width: double.infinity,
                                           child: StreamBuilder <QuerySnapshot>(
                                             stream: FoodCubit.get(context).StreamgetSlider(),
                                             builder: (context, snapshot)
                                             {
                                               if(!snapshot.hasData||snapshot.data!.size==0)
                                                 return Center(child: Text('',style: TextStyle(fontSize: 20.sp),));
                                               else
                                               {
                                                 if(snapshot.connectionState==ConnectionState.waiting)
                                                   return Center(child: Text('Loading....',style: TextStyle(fontSize: 15.sp),));
                                                 else
                                                   return CarouselSlider.builder(
                                                       scrollPhysics: BouncingScrollPhysics(),
                                                       autoSliderDelay: Duration(seconds: 5),
                                                       enableAutoSlider: true,
                                                       unlimitedMode: true,
                                                       autoSliderTransitionCurve:
                                                       Curves.fastOutSlowIn,
                                                       autoSliderTransitionTime:  Duration(milliseconds: 100),
                                                       slideTransform: DefaultTransform(),
                                                       slideIndicator: CircularSlideIndicator(
                                                         itemSpacing: 10.sp,
                                                         indicatorBackgroundColor:
                                                         Colors.white,
                                                         currentIndicatorColor: Colors.black,
                                                         padding: EdgeInsets.only(bottom: 1.h),
                                                         indicatorRadius: 2.5.sp,
                                                       ),
                                                       slideBuilder: (index) {
                                                         QueryDocumentSnapshot<Object?>
                                                         sliderImage = snapshot.data!.docs[index];
                                                         return Card(
                                                           elevation: 8,
                                                           color: Colors.grey,
                                                           shadowColor: Colors.grey,
                                                           margin: EdgeInsets.only(bottom: 0),
                                                           clipBehavior: Clip.antiAliasWithSaveLayer,
                                                           child: CachedNetworkImage(
                                                             //            sliderImage['image'],
                                                             fit: BoxFit.cover,
                                                             imageUrl: sliderImage['image'],
                                                             placeholder: (context, url) => Center(
                                                               child: Shimmer.fromColors(
                                                                 baseColor: Colors.grey[350]!,
                                                                 highlightColor: Colors.grey[100]!,
                                                                 child: Container(
                                                                   height: 55.h,
                                                                   color: Colors.grey[700],
                                                                 ),
                                                               ),
                                                             ),
                                                             errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                                                           ),
                                                         );
                                                       },
                                                       itemCount: snapshot.data!.docs.length);
                                               }
                                             },
                                           ),
                                         );
                                     }
                                     else if(doc['status']==false)
                                       return Container(
                                           padding: EdgeInsetsDirectional.all(2.h),
                                           decoration: BoxDecoration(
                                             border: Border.all(color: HexColor('#8d2422')),),
                                 //          height: 20.h,
                                           width:100.w,child: Center(child: Column(
                                         children: [
                                           Text('عفوا',textAlign: TextAlign.center,
                                             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp),
                                           ),
                                           Text('!لا يتم استقبال الطلبات الان',textAlign: TextAlign.center,
                                             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp),
                                           ),
                                         ],
                                       )));
                                 }
                                 return Text('',style: TextStyle(color: Colors.white),);
                               },
                             );
                           },
                         ),
                         SizedBox(
                           height: 2.h,
                         ),
                         Row(
                           children: [
                             SizedBox(
                               width: 10.sp,
                             ),
                   Shimmer.fromColors(
                     baseColor: Colors.black,
                     highlightColor: HexColor('#ff0000'),
                     child: Text(
                       'Categories',
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 20.sp,
                         fontWeight:
                         FontWeight.bold,
                       ),
                     ),
                   ),
                             /*
                             Text(
                               'Categories',
                               style: TextStyle(
                                   color: Colors.black, fontSize: 15.sp),
                             ),

                              */
                           ],
                         ),
                         SizedBox(
                           height: 10.sp,
                         ),
                         Container(
                           height: 12.h,
                           child: StreamBuilder <QuerySnapshot>(
                             stream: FoodCubit.get(context).getListHori(),
                             builder: (context, snapshot)
                             {
                               if(!snapshot.hasData||snapshot.data!.size==0)
                                 return Center(child: Text('',style: TextStyle(fontSize: 20.sp),));
                               else
                               {
                                 List<getListHoriModel>ListHoriModel =[];
                                 List<String>Ids =[];
                                 for(var doc in snapshot.data!.docs)
                                 {
                                   ListHoriModel.add(getListHoriModel(name:doc['name'],image:doc['image']));
                                   Ids.add(doc.id);
                                 }
                                 return ListView.separated(
                                     controller: ListController,
                                     scrollDirection: Axis.horizontal,
                                     shrinkWrap: true,
                                     itemBuilder: (context, index) =>BuildTextButton(context,index,ListHoriModel[index],Ids[index]),
                                     separatorBuilder: (context, index) =>
                                         SizedBox(
                                           width: 1.2.w,
                                         ),
                                     itemCount: ListHoriModel.length);
                               }
                             },
                           ),
                         ),
                         StreamBuilder <QuerySnapshot>(
                           stream: FoodCubit.get(context).getListHoriz(FoodCubit.get(context).Number),
                           builder: (context, snapshot)
                           {
                             if(!snapshot.hasData)
                               return Center(child: Text(''));
                             else
                             {
                               List<checkenModel>Orders =[];
                               for(var doc in snapshot.data!.docs)
                               {
                                 Orders.add(checkenModel(name:doc['name'],description: doc['description']
                                     ,price:doc['price'],image:doc['image'],availability:doc['availability'],text:doc['text'],
                                 discount: doc['discount'],beforeDiscount: doc['beforeDiscount'],
                                 ));
                               }
                               return ConditionalBuilder(
                                 condition: Orders.length > 0,
                                 builder: (BuildContext context) => Container(
                                   child: GridView.count(
                                     crossAxisCount: 2,
                                     shrinkWrap: true,
                                     childAspectRatio: 1 / 1.3,
                                     crossAxisSpacing: 2,
                                     mainAxisSpacing: 2,
                                     physics: NeverScrollableScrollPhysics(),
                                     children: List.generate(Orders.length, (index) => BuilView(Orders[index],context)),
                                   ),
                                 ),
                                 fallback: (BuildContext context) =>
                                     Center(child: CircularProgressIndicator()),
                               );
                             }
                           },
                         ),
                       ],
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

 BuildTextButton(context,index, getListHoriModel listHoriModel, String id)=>Padding(
   padding:  EdgeInsets.only(left: 1.h),
   child: Container(
     child: Column(
       children: [
         Container(
           padding: EdgeInsetsDirectional.only(top: .1.h,bottom: .2.h,end: .5.h,start: .5.h),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.all(
                 Radius.circular(3.h)),
             color: FoodCubit.get(context).selectedIndex != null && FoodCubit.get(context).selectedIndex == index ? HexColor('#8d2422')
             // HexColor('#EBFDF2')
                 : Colors.grey[300],
           ),

           child: TextButton(
             onPressed: () {
               FoodCubit.get(context).onSelected(index);
               FoodCubit.get(context).getId(id);
             },
             child: Row(
               mainAxisAlignment:
               MainAxisAlignment.start,
               children: [
                 CircleAvatar(
                   child: Image(
                     image: NetworkImage(
                       '${listHoriModel.image}',
                     ),
                     fit: BoxFit.cover,
                     height: 4.5.h,
                     width: 4.1.h,
                   ),
                   backgroundColor:
                   Colors.white,
                   radius: 3.h,
                 ),
                 SizedBox(
                   width: 1.w,
                 ),
                 Text(
                   '${listHoriModel.name}',
                   style: TextStyle(
                     fontSize: 12.sp,
                     fontWeight:
                     FontWeight.bold,
                     color: FoodCubit.get(
                         context)
                         .selectedIndex !=
                         null &&
                         FoodCubit.get(
                             context)
                             .selectedIndex ==
                             index
                         ? Colors.white
                         : Colors.black,
                   ),
                 ),
               ],
             ),
           ),

         ),
         SizedBox(
           height: .6.h,
         ),
         if (FoodCubit.get(context).selectedIndex != null && FoodCubit.get(context).selectedIndex == index)
           LayoutBuilder(
             builder: (context,constraints)=>
              Container(
                   height: .4.h,
                   width: 30.w,
                   color: HexColor('#8d2422'),
                 ),
           ),
       ],
     ),
   ),
 );
 Widget BuilView(checkenModel model, context) => InkWell(
   child: Container(
     color: Colors.grey[100],
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Expanded(
           child: Padding(
             padding:  EdgeInsets.only(left: .4.h,right: .4.h),
             child:Stack(
               alignment: AlignmentDirectional.topCenter,
               children: [
                 /*
                 Container(
                   width: double.infinity,
                //   height: 20.h,
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(bottomLeft:Radius.circular(2.h) ,bottomRight:Radius.circular(2.h) ),
                       image: DecorationImage(
                           fit: BoxFit.cover,
                           image: NetworkImage('${model.image}')
                       )
                   ),
                 ),
 */
              Container(
             child: CachedNetworkImage(
               width: double.infinity,
             fit: BoxFit.cover,
               imageUrl: '${model.image}',
               imageBuilder: (context, imageProvider) => Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(bottomLeft:Radius.circular(2.h) ,bottomRight:Radius.circular(2.h) ),
                   image: DecorationImage(
                       image: imageProvider, fit: BoxFit.cover),
                 ),
               ),
               placeholder: (context, url) => Shimmer.fromColors(
                 baseColor: Colors.grey[350]!,
                 highlightColor: Colors.grey[100]!,
                 child: Container(
                   width: double.infinity,
                   color: Colors.grey[700],
                 ),
               ),
               errorWidget: (context, url, error) => Icon(Icons.error),
             ),
           ),
                 if(model.availability==false)
                 Container(
                   color: Colors.black54,
              //     height: 5.h,
                   width: double.infinity,
                   child: Padding(
                     padding:  EdgeInsets.all(.5.h),
                     child: Text('غير متاح الان',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13.sp),),
                   ),
                 ),
                 if(model.discount==true)
                 Container(
                   color: Colors.red.withOpacity(.7),
               //    height: 5.h,
                     width: double.infinity,
                     child: Padding(
                       padding:  EdgeInsets.all(.5.h),
                       child: Text('${model.text}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13.sp,),textAlign: TextAlign.center,),
                     )),
               ],
             ),
           ),
         ),
         SizedBox(
           height: .2.h,
         ),
         Container(
           child: Text(
             '${model.name}',
             style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
             maxLines: 2,
           ),
         ),
         Container(
           width: double.infinity,
           child: Padding(
             padding:  EdgeInsets.only(left: .5.h,right: .5.h),
             child: Center(
               child: Text(
                 '${model.description}',
                 maxLines: 3,
                 overflow: TextOverflow.ellipsis,
                 style: TextStyle(fontSize: 10.5.sp, color: Colors.grey,),textAlign: TextAlign.center,
               ),
             ),
           ),
         ),
         if(model.discount==false)
         Container(
           //     margin: const EdgeInsets.all(15.0),
           decoration: BoxDecoration(
             border: Border.all(color: HexColor('#8d2422')),),
           child: Text(' السعر : ${model.price} جنيه ',
               style: TextStyle(color: Colors.black,fontSize: 12.sp,)),
         ),
         if(model.discount==true)
         Padding(
           padding:  EdgeInsets.symmetric(horizontal: .5.h),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Expanded(
                 child: Text('بدلا من: ${model.beforeDiscount} ج',textAlign: TextAlign.center,
                     style: TextStyle(color: Colors.red,fontSize: 10.sp,decoration: TextDecoration.lineThrough)),
               ),
               Container(
                 padding: EdgeInsetsDirectional.zero,
                 decoration: BoxDecoration(
                   border: Border.all(color: HexColor('#8d2422')),),
                 child: Text(' السعر : ${model.price} ج ',textAlign: TextAlign.center,
                     style: TextStyle(color: Colors.black,fontSize: 11.sp,)),
               ),
               SizedBox(width: 2.w),
             ],
           ),
         ),
         SizedBox(height: .5.h,),
       ],
     ),
   ),
   onTap: () {
     FoodCubit.get(context).number=1;
     int a = model.price!;
     NavigateTo(
         context,
         ItemDescription(model.name!, model.price!, model.image!,
             model.description!, a,model.availability!));
   },
 );

