import 'package:bloc/bloc.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubit.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/modules/splashScreen/splashScreen.dart';
import 'package:easy_eat/shared/bloc_observer/bloc_observer.dart';
import 'package:easy_eat/shared/casheHelper/sharedPreferance.dart';
import 'package:easy_eat/shared/constants/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';




void main() async{
  //runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CasheHelper.init();
  uId = CasheHelper.getData(key: 'uId');
  print('uidfROmMain ${uId}') ;
  /*
  print('main uId == ${uId}');
  if(uId!= null)
  {
    widget = FoodLayoutScreen();
  }else
  {
    widget = SplashScreen();
  }

   */
  //cloudMesssaging
  OneSignal.shared.init('ab900aa0-133a-42bb-9784-d9e2db2680c5', iOSSettings: {
    OSiOSSettings.autoPrompt: false,
    OSiOSSettings.inAppLaunchUrl: false
  });
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
  //

  runApp(MyApp());
}
class MyApp extends StatelessWidget {

   MyApp({Key? key, }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoodCubit(InitialFoodState()),
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,  deviceType)
        {
          return MaterialApp(
      //      builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            title: 'قصر الشام',
            theme: ThemeData(
              checkboxTheme: CheckboxThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white,
                selectedItemColor: HexColor('#7a0000'),
                unselectedItemColor: Colors.grey,
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                selectedLabelStyle:TextStyle(color: HexColor('#184a2c')),
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,

              ),
              primarySwatch: Colors.red,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
            ),
            home:SplashScreen(),
          );
        },
      ),
    );
  }
}

