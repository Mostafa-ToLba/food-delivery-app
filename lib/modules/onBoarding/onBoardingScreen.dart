
import 'package:easy_eat/foodLayout/foodLayoutScreen.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/modules/login/login_screen.dart';
import 'package:easy_eat/shared/casheHelper/sharedPreferance.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
var boardingController =PageController();
 class BoardingModel
{
//  final String? Image;
  final String? Title;
  final String? Body;
  String? image2;

  BoardingModel({ this.Title, required this.Body,this.image2});

}
void Onsubmitt(context)
{
  CasheHelper.SaveData(key: 'onBoarding', value: true)!.
  then((value)
  {
    if(value == true )
      NavigateAndFinsh(context,FoodLayoutScreen());
     isLast=false;
  }
  );
}

void submitt(context)
{
  CasheHelper.SaveData(key: 'onBoarding', value: true)!.
  then((value)
  {
    if(value == true )
      NavigateAndFinsh(context,FoodLayoutScreen());
    isLast=false;
  }

  );
}

bool isLast=false;

class OnboardingScreen extends StatefulWidget {


   OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List <BoardingModel> Boarding =
  [
    BoardingModel(
      image2: 'Assets/animation/boarding1.json',
      Body: 'اختيار الطعام',
      Title: 'حدد اختيارك من المنيو واطلب مباشره من التطبيق ',
    ),
    BoardingModel(
      image2: 'Assets/animation/moto.json',
      Body: 'حدد مكان التسليم ',
      Title: ' حدد موقعا دقيقا واحصل علي طعامك عند باب منزلك',
    ),
    BoardingModel(
      image2: 'Assets/animation/athome.json',
      Body: 'التوصيل الي المنزل',
      Title: 'اطلب عبر الانترنت واحصل علي توصيل الطعام الي منزلك ',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
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
      child: Builder(
        builder: (context) {
          FoodCubit.get(context).getNotify();
          return BlocConsumer<FoodCubit,FoodCubitStates>(
            listener: (BuildContext context, state) {  },
            builder: (BuildContext context, Object? state) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness:  Brightness.dark,
                ),
                child: Scaffold(
                  body: PageView.builder(itemBuilder:(context,index)=>BoardingItem(context,Boarding[index]),
                    itemCount:Boarding.length,controller: boardingController,physics: BouncingScrollPhysics(),
                   onPageChanged:(index)
                   {
                     if(index==Boarding.length-1)
                     {
                       setState(() {
                         isLast=true;
                       });

                     }else
                       setState(() {
                         isLast=false;
                       });
                   } ,
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}
Widget BoardingItem(context, BoardingModel boarding)=>SingleChildScrollView(
  child:   Column(
    children: [
          Padding(
            padding:  EdgeInsets.only(top:7.h ),
            child: Container(height: 45.h,child: Lottie.asset('${boarding.image2}')),
          ),
      Center(child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 1.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${boarding.Body}',maxLines: 3,textAlign: TextAlign.center,style:
                TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w900,color:Colors.black),),
                SizedBox(height: 1.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 2.h),
                  child: Text(' ${boarding.Title}',textAlign: TextAlign.center,style:
                  TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w800,color: Colors.grey),),
                ),
              ],
            ),
          ),
      //    SizedBox(height: 3.h,),
          SizedBox(height: 5.h,),
          SmoothPageIndicator(
           controller: boardingController,  // PageController
            count:  3,
           textDirection: TextDirection.ltr,
         //  effect:  WormEffect(activeDotColor: HexColor('#7a0000'),dotColor: Colors.grey[300]!,dotHeight: .5.h,dotWidth: 6.w
        effect: ExpandingDotsEffect(
         dotColor: HexColor('#7a0000'),
      activeDotColor: HexColor('#7a0000'),
          expansionFactor: 3.5,
             dotHeight: 11,
             ),
            ),
          SizedBox(height: 3.h,),
          Container(
              width: 85.w,
              height: 7.h,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),color: HexColor('#7a0000')),
              child: MaterialButton(
                color: HexColor('#7a0000'),
                onPressed: ()
              {
                if(isLast)
                {
                  submitt(context);
                }else
                {
                  boardingController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.decelerate);
                }
                }
              ,child: Text('التالي',style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.w700),),)
          ),
          TextButton(onPressed: ()
          {
            Onsubmitt(context);
          }, child: Text('تخطي',style: TextStyle(color: HexColor('#7a0000'),fontSize: 17.sp,fontWeight: FontWeight.w700),))
        ],
      )),
    ],
  ),
);

