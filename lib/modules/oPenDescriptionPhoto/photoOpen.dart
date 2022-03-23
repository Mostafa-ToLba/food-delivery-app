
 import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PhotoOpen extends StatelessWidget {
  String Image;

    PhotoOpen( this.Image, {Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Scaffold(backgroundColor: Colors.black,
       appBar: AppBar(backgroundColor: Colors.black,
         leadingWidth: 15.w,
         toolbarHeight: 8.h,
         leading:IconButton(iconSize: 18.sp,icon: Icon(IconBroken.Arrow___Left_2,size: 18.sp,color: Colors.white,), onPressed: ()
         {
           Navigator.pop(context);
         },) ,
       ),
       body: Container(
           decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('${this.Image}')))
       ),
     );
   }
 }
