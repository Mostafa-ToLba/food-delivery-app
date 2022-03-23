import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

Widget defultButton ({

  required Color? backGround ,
  required double? width,
  required var function,
   String text='' ,
  required height,


}) => Container(

  height: height,
  color: backGround,
  width: width,
  child: MaterialButton( onPressed: function,
    child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 17.0,
          color: Colors.white,
        )
    ),
  ),
);


Widget defultformfield ({

  TextEditingController? controle ,
  var onfieldsubmite ,
  var validate ,
  var onchange ,
  var ontap ,
  TextInputType? keyboard ,
  String? label ,
  IconData? prefix ,
  IconData? suffix ,
  bool isPassword= false,
  var suffixPressed ,
  var textStyle,
  var contentPadding ,
}) =>

    TextFormField(
      controller: controle,
      strutStyle: StrutStyle(height: 1,),
      onFieldSubmitted:onfieldsubmite,
      onTap:ontap,
      validator: validate,
      onChanged: onchange,
      keyboardType: keyboard,
      obscureText: isPassword,
      style: textStyle,

      decoration:  InputDecoration(
       //  fillColor: HexColor('F6F6F6'),
       //   filled: true,

          contentPadding: contentPadding,
          prefixIcon: Icon(
            prefix,
            color: Colors.grey,size: 18.5.sp,
          ),
          suffixIcon: suffix !=null? IconButton (
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
              color: Colors.grey,size:16.sp ,
            ),
          ) : null ,


          label: Text(
            label!,
            style: textStyle,
          ),


          border:OutlineInputBorder()
      ),

    );


void NavigateTo(context,Widget) => Navigator.push(context, MaterialPageRoute(
  builder:(context) => Widget,
),);


dynamic NavigateAndFinsh(context,dynamic)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
  builder:(context) => dynamic,
), (route) => false);


void defaultToast({ required String message, required Color color, BuildContext? context,}) => showToast( message, context: context, animation: StyledToastAnimation.scale, reverseAnimation: StyledToastAnimation.fade, position: StyledToastPosition.center, animDuration: const Duration(seconds: 1), duration: const Duration(seconds: 3), curve: Curves.elasticOut, reverseCurve: Curves.linear, backgroundColor: color, );