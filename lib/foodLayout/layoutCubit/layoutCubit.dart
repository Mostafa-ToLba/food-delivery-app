


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_eat/foodLayout/layoutCubit/layoutCubitStates.dart';
import 'package:easy_eat/models/addToCartModel/addToCartModel.dart';
import 'package:easy_eat/models/checkenModel/checkenModel.dart';
import 'package:easy_eat/models/homeModel/homeModel.dart';
import 'package:easy_eat/models/makeOrder/makeOrder.dart';
import 'package:easy_eat/models/myOrders/myOrders.dart';
import 'package:easy_eat/models/registerModel/registemModel.dart';
import 'package:easy_eat/models/userInformation/userInformation.dart';
import 'package:easy_eat/modules/CartScreen/cartScreen.dart';
import 'package:easy_eat/modules/LoadingPage/LoadingPage.dart';
import 'package:easy_eat/modules/homeTwo/homeTwo.dart';
import 'package:easy_eat/modules/login/login_screen.dart';
import 'package:easy_eat/modules/makeOrder/makeOrder.dart';
import 'package:easy_eat/modules/myOrder/myOrderScreen.dart';
import 'package:easy_eat/modules/userProfile/userProfile.dart';
import 'package:easy_eat/shared/casheHelper/sharedPreferance.dart';
import 'package:easy_eat/shared/componenet/component.dart';
import 'package:easy_eat/shared/constants/constants.dart';
import 'package:easy_eat/shared/styles/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FoodCubit extends Cubit<FoodCubitStates> {
  static BuildContext? context;

  FoodCubit(FoodCubitStates InitialFoodState) : super(InitialFoodState);

  static FoodCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  onSelected(int index) {
    selectedIndex = index;
    emit(ChangeHorizontalListColor());
  }

  List<Widget> Screens =
  [
    HomeTwo(),
    CartScreen(),
    MyOrderScreen(),
    UserProfile(),
  ];

  int currentIndex = 0;

  ChangeBottomNavItem(int index, context) {
    currentIndex = index;
    if(index==1||index==2||index==3)
    {
      if(FirebaseAuth.instance.currentUser==null)
        ShowDialogForLogin(context);
    }
    emit(ChangeNavBarItemState());
  }


  int number = 1;

  Plus() {
    number++;
    emit(plusSuccessState());
  }

  Minus() {
    number--;
    emit(minusSuccessState());
  }

  Future addToCartFunction({
    String? name,
    int? price,
    int? num,
    String? text,
    int? NumFromCart,
  }) async {
    AddToCart addToCart = await AddToCart(
      name: name,
      price: price,
      num: num,
      text: text,
      NumFromCart: price,
      username: '',
      phone: '',
      location: '',
      time: '',
      uId: '',
      total: 0,
      orderIsOk: false,
    );
    FirebaseFirestore.instance.collection('users').
    doc(FirebaseAuth.instance.currentUser!.uid).
    collection('addToCart').add(addToCart.toMap()).then((value) {
  //    emit(addToCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(addToCartErrorState());
    });
    deleteNull();
  }


  List<AddToCart>?GetCartList1 ;
  List<AddToCart>GetCartList = [];
  List<String>Ids =[];
  List<String>?Idss ;

  Future getCart() async {
    GetCartList = [];
    Ids = [];
    emit(getCartLoadingState());
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['name'] != null && element.data()['num'] != null &&
            element.data()['price'] != null)
          GetCartList.add(AddToCart.fromJson(element.data()));
        Ids.add(element.id);
      });
    }).then((value) {
      emit(getCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getCartErrorState());
    });
  }

  Future getCart2() async {
    GetCartList = [];
    Ids = [];
    emit(getCartLoadingState());
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid)
        .collection('addToCart')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        if (element.data()['name'] != null && element.data()['num'] != null &&
            element.data()['price'] != null)
          GetCartList.add(AddToCart.fromJson(element.data()));
        Ids.add(element.id);
      });
      emit(getCartSuccessState());
    });
  }


  var Total;

  Future totalPrice() async {
    Total = 0;
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.data()['name'] != null && element.data()['num'] != null &&
            element.data()['price'] != null)
          Total += element.data()['price'];
      });
      emit(getTotalSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(getTotalErrorState());
    });
  }

  Future deleteOrder(id) async {
    emit(deleteItemCartLoadingState());
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid)
        .collection('addToCart').doc(id).delete().then((value)  {
      getCart2();
      totalPrice();
      getDiscount2();
  //    getDiscount();
      getDiscount0();
      emit(deleteItemCartSuccessState());
    }).catchError((error) {
      emit(deleteItemCartErrorState());
    });
  }

  Future deleteNull() async {
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).
    collection('addToCart').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['name'] == null && element.data()['num'] == null &&
            element.data()['price'] == null) {
          FirebaseFirestore.instance.collection('users').doc(
              FirebaseAuth.instance.currentUser!.uid).
          collection('addToCart').doc(element.id).delete();
        }
      });
    });
  }


  Stream<QuerySnapshot> getNumberOfItem2() {
    return FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser?.uid)
        .collection('addToCart').snapshots();
  }
/*
 //futureBuilder
  int? dataLength;

  Future<List<QueryDocumentSnapshot<
      Map<String, dynamic>>>> getSliderImageFromDb() async {
    var fireStore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await fireStore.collection(
        'slider').get();
    dataLength = snapshot.docs.length;
    return snapshot.docs;
  }
  Widget aa(context) =>Container(
    height: 35.h,
    width: double.infinity,
    child: FutureBuilder(
      future: FoodCubit.get(context).getSliderImageFromDb(),
      builder: (_, AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>snapShot)
      {
        return snapShot.data == null
            ? Center(child: CircularProgressIndicator())
            : CarouselSlider.builder(
            scrollPhysics: BouncingScrollPhysics(),
            autoSliderDelay: Duration(seconds: 4),
            enableAutoSlider: true,
            unlimitedMode: true,
            autoSliderTransitionCurve:
            Curves.fastOutSlowIn,
            autoSliderTransitionTime:  Duration(seconds: 1),
            slideTransform: DefaultTransform(),
            slideIndicator: CircularSlideIndicator(
              indicatorBackgroundColor:
              Colors.white,
              currentIndicatorColor: Colors.black,
              padding: EdgeInsets.only(bottom: 10),
              indicatorRadius: 4,
            ),
            slideBuilder: (index) {
              DocumentSnapshot<Map<String, dynamic>>
              sliderImage =
              snapShot.data![index];
              return Container(
                child: Image.network(
                  sliderImage['image'],
                  fit: BoxFit.cover,
                ),
              );
            },
            itemCount: snapShot.data!.length);
      },
    ),
  );

 */

  bool orderIsOk=false;
  bool confirmOrder=false;
  bool sendOrder=false;
  Future showAlertDialog(BuildContext context,
      {LocationController, NameController, PhoneController, total}) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء",
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    /*
    state is! updateCartLoadingState||
              state is! makeOrderLoadingState||state is! makeOrderLoadingState||
              state is! getOsOfAdminLoadingState||state is! NotifacationLoader
     */
    Widget continueButton = TextButton(
      child: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("اكمال الطلب",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
      ),
      onPressed: () async {
        NavigateAndFinsh(context, LoadingPage());
        orderIsOk =false;
        confirmOrder=false;
        sendOrder=false;
        await updateCart(location: LocationController, phone: PhoneController, username: NameController, total: total)
            .then((value)async{
          await   updateCart(location: LocationController, phone: PhoneController, username: NameController, total: total);
            await  makeOrder2();
            orderIsOk =true;
        await  setIsOkFunction();
          setUserLocation(name:NameController ,phone:PhoneController ,location:LocationController );
          getOsOfAdmin().then((value) {
            SendNotificationToSomeOne(content: 'وصل اوردر جديد',
                playerIds: ['${AdminOs}'],
                heading: 'قصر الشام ');
          });
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تاكيد الطلب ",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
      content: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("هل حقا تريد اكمال الطلب ؟",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w800)),
            Text(
                "عند الضغط علي اكمال الطلب لا يمكنك الغائه او تعديله مره اخري للتاكيد اضغط اكمال الطلب ",
                style: TextStyle(fontSize: 13.sp)),
          ],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Future getOsOfAdmin() async {
    await FirebaseFirestore.instance.collection('osOfAdmin').doc(
        'USuCyBQ4T4vv83JlPDAy').get().then((value) {
      AdminOs = value.data()!['admin'];
      print('قبل الايمت ${AdminOs}');
      emit(getOsOfAdminState());
    }).then((value) {
      print('بعد الايمت ${AdminOs}');
      emit(getOsOfAdminState());
    }).catchError((error) {
      emit(getOsOfAdminErrorState());
    });
  }

  String? AdminOs;

  makeOrder({
    String? name,
    String? phone,
    String? uId,
    String? location,
    int? num,
    int? price,
    String? instructions,
    String? time,
    String? itemName,
  }) {
    makeOrderModel orderModel = makeOrderModel(name: name,
        phone: phone,
        uId: FirebaseAuth.instance.currentUser!.uid,
        location: location,
        num: num,
        price: price,
        instructions: instructions,
        time: time,
        itemName: itemName);

    FirebaseFirestore.instance.collection('orders').doc(
        FirebaseAuth.instance.currentUser!.uid).set(orderModel.toMap()).then((
        value) {
      FirebaseFirestore.instance.collection('orders').doc(
          FirebaseAuth.instance.currentUser!.uid).collection('userOrders').
      add(orderModel.toMap()).then((value) {
        emit(makeOrderSuccessState());
      }).catchError((error) {
        emit(makeOrderErrorState());
      }).catchError((error) {
        print(error.toString());
        emit(makeOrderErrorState());
      });
    });
  }

  Future makeOrder2() async {
    //   AddToCart addToCart;
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await FirebaseFirestore.instance.collection('orderss').doc(
            FirebaseAuth.instance.currentUser!.uid).set({
          'orderIsOk':element.data()['orderIsOk'],
          'name': element.data()['username'],
          'location': element.data()['location'],
          'phone': element.data()['phone'],
          'total': element.data()['total'],
          'time': element.data()['time'],
          'uId': element.data()['uId'],
          'color': true,
          'confirmOrder':element.data()['confirmOrder'],
          'sendOrder':element.data()['sendOrder'],
        });
     await   FirebaseFirestore.instance.collection('orderss').doc(
            FirebaseAuth.instance.currentUser!.uid)
            .collection('cartOrders')
            .add(element.data());
  //      emit(makeOrderSuccessState());
      });
    }).then((value)async {
   //   updateOrders();
     await updateOrders();
     await  deleteOrdersInCart();
     await  MyOrderss();
      //    updateCart();
    //      emit(makeOrderSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(makeOrderErrorState());
    });
  }

  Future updateCart({
    required String location,
    required String phone,
    required String username,
    required var total,
  }) async {
    orderIsOk =false;
    confirmOrder=false;
    sendOrder=false;
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((value) {
      value.docs.forEach((element) async{
       await element.reference.update(
            {
              'location': location,
              'phone': phone,
              'username': username,
              'time': DateFormat.yMMMMd().add_jm().format(DateTime.now()),
              'uId': FirebaseAuth.instance.currentUser!.uid,
              'total': total,
              'orderIsOk':orderIsOk,
              'confirmOrder':confirmOrder,
              'sendOrder':sendOrder,
            });
      });
    }).then((value) {
      emit(updateCartSuccessState());
    }).catchError((error) {
      emit(updateCartErrorState());
    });
  }

  HomeModel? homeModel;

  getOrdersToAdmin() {
    FirebaseFirestore.instance.collection('orderss').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('cartOrder').get().then((value) {
          value.docs.forEach((element) {
            homeModel = HomeModel.fromJson(element.data());
            emit(getOrdersToAdminSuccessState());
          });
          emit(getOrdersToAdminSuccessState());
        });
        emit(getOrdersToAdminSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(getOrdersToAdminErrorState());
    });
  }

  Stream<QuerySnapshot> LoadOrders() {
    return FirebaseFirestore.instance.collection('orderss').snapshots();
  }

  Stream<QuerySnapshot> OrderDetails(id) {
    return FirebaseFirestore.instance.collection('orderss').doc(
        id)
        .collection('cartOrders')
        .snapshots();
  }

  bool color = true;

  changeColorofOrder(id) {
    color = !color;
    emit(changeColorofOrderState());
    color = false;
  }

  Future deleteOrdersInCart() async {
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
        emit(deleteItemCartSuccessState());
      }
      emit(deleteItemCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(deleteItemCartErrorState());
    });
  }

  Future DeleteOrderByAdmin(id) async {
    await FirebaseFirestore.instance.collection('orderss').doc(id)
        .delete()
        .then((value) {
      FirebaseFirestore.instance.collection('orderss').doc(id).collection(
          'cartOrders').get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
        emit(deleteOrderByAdmin());
      });
      emit(deleteOrderByAdmin());
    }).catchError((error) {
      print(error.toString());
      emit(deleteOrderByAdminErrorState());
    });
  }

  bool status = true;

  changeStatus() {
    status = !status;
    emit(changeStatusState());
  }

  setStatus(setonlinebyadmin) {
    FirebaseFirestore.instance.collection('online')
        .doc('kmxXeXAPxa88b4EjGSJW')
        .update({'status': setonlinebyadmin})
        .then((value) {
      emit(changeStatusState());
    }).catchError((error) {
      print(error.toString());
      emit(changeStatusErrorState());
    });
  }

  bool getstatus = true;

  getStatus() {
    FirebaseFirestore.instance.collection('online').snapshots().listen((event) {
      event.docs.forEach((element) {
        getstatus = element.data()['status'];
      });
    });
  }

  Stream<QuerySnapshot> getstatusfromdata() {
    return FirebaseFirestore.instance.collection('online').snapshots();
  }


  Future updateOrders() async {
   await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        await   FirebaseFirestore.instance.collection('orderss').doc(
            FirebaseAuth.instance.currentUser!.uid).update(
            {
              'location': element.data()['location'],
              'name': element.data()['username'],
              'phone': element.data()['phone'],
              'time': element.data()['time'],
              'total': element.data()['total'],
            }).then((value) {
          emit(updateOrdersState());
        });
      });
   //   emit(updateOrdersState());
    });
  }


  //oneSignal
  Future getNotify() async {
    OneSignal.shared.getPermissionSubscriptionState().then((state) {
      DocumentReference ref = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      ref.get().then((value) {
        if (value['osUserID'] == '' || value['osUserID'] == null) {
          ref.update({
            'osUserID': state.subscriptionStatus.userId,
          }).then((value) {
            emit(getNotiftyState());
          });
        }
      });
      //     emit(getNotiftyState());
    });
  }

  SendNotificationToSomeOne({content, playerIds, heading}) {
    OneSignal.shared.postNotification(OSCreateNotification(
      additionalData: {
        'data': 'this is our data',
      },
      subtitle: 'MyChat',
      androidSmallIcon: '${IconBroken.Message}',
      playerIds: playerIds,
      content: content,
      heading: heading,
    ));
    emit(pushNotificationToSomeone());
  }

  String? osOfUser;

  String? name;

  getOsofUser(id) {
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      osOfUser = value.data()!['osUserID'];
      name = value.data()!['name'];
      emit(pushNotificationToSomeone());
    });
  }

  UserModel getUserData = UserModel(osUserID: '',
      phone: '',
      uId: '',
      name: '',
      password: '',
      email: '',
  );

  Future GetUserDataFunction() async {
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      getUserData = UserModel.fromJson(value.data()!);
    }).then((value) {
      emit(getUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(getUserDataErrorState());
    });
  }

  Future signOut() async
  {
    await FirebaseAuth.instance.signOut().then((value) {
      //   uId='${null}';
      CasheHelper.removeData(key: 'uId').then((value) {
        uId ='';
        print('signOut UiD == ${uId}');
        emit(SocialCubitSignOutSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCubitSignOutErrorState());
    });
  }

  bool? sameTime;

  Future sameTimeMakingOrder() async {
    await FirebaseFirestore.instance.collection('orderss').doc(
        FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      if (value.exists == true) {
        sameTime = true;
      }
      else if (value.exists == false)
        sameTime = false;
    }).then((value) {
      emit(makingOrdersOnSameTimeSuccessState());
    }).catchError((error) {
      emit(makingOrdersOnSameTimeErrorState());
    });
  }


  Stream<QuerySnapshot> getListHori() {
    return FirebaseFirestore.instance.collection('homeTwo').snapshots();
  }

  String Number = '0';

  getId(id) {
    Number = id;
    emit(getIdState());
  }

  Stream<QuerySnapshot> getListHoriz(id) {
    return FirebaseFirestore.instance.collection('homeTwo').doc(id)
        .collection('get')
        .snapshots();
  }

  List<checkenModel> Modelss = [];


  //strea get cart
  Future GetCart2() async {
    GetCartList = [];
    Ids = [];
    emit(getCartLoadingState());
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid)
        .collection('addToCart')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        if (element.data()['name'] != null && element.data()['num'] != null &&
            element.data()['price'] != null)
          GetCartList.add(AddToCart.fromJson(element.data()));
        Ids.add(element.id);
      });
      emit(getCartSuccessState());
    });
  }


  //signUpalerting

  Future SignUpshowAlertDialog(BuildContext context,) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء", style: TextStyle(fontSize: 15.sp),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("تسجيل الخروج", style: TextStyle(fontSize: 15.sp)),
      ),
      onPressed: () async {
        FoodCubit.get(context).signOut().then((value) {
          NavigateAndFinsh(context, LoginScreen());
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تسجيل الخروج ", style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
      content: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text(
            "هل تريد تسجيل الخروج ؟", style: TextStyle(fontSize: 14.sp)),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<AddToCart>GetCartList2 = [];

  Stream<QuerySnapshot> StreamGetCart2() {
    return FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid)
        .collection('addToCart').snapshots();
  }

  Future ChangeNumToPlusFromCart(id, num, NumFromCart, price) async {
    await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).collection('addToCart').doc(id)
        .update({'price': price + NumFromCart}).then((value) {
      FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid).collection('addToCart').doc(
          id)
          .update({'num': num + 1});
      totalPrice();
   //   getDiscount();
      getDiscount2();
      getDiscount0();
    });
  }

  Future ChangeNumToMinusFromCart(id, num, NumFromCart, price) async {
    if (num > 1) {
      await FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid).collection('addToCart').doc(
          id)
          .update({'price': price - num}).then((value) {
        FirebaseFirestore.instance.collection('users').doc(
            FirebaseAuth.instance.currentUser!.uid).collection('addToCart').doc(
            id)
            .update({'num': num - 1});
        totalPrice();
     //   getDiscount();
        getDiscount2();
        getDiscount0();
      });
    }
  }




  Future EkmalEldf3showAlertDialog(BuildContext context,) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء", style: TextStyle(fontSize: 15.sp),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("اكمال الدفع", style: TextStyle(fontSize: 15.sp)),
      ),
      onPressed: () async {
          NavigateTo(context, MakeOrder((Total-(a*Total).round())+delivary));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تأكيد الطلبات", style: TextStyle(fontSize: 15.sp)),
      content: Container(
        height: 45.h,
        width: 45.h,
        child: Padding(
          padding: EdgeInsets.only(right: .5.h, left: .5.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>Alerting(GetCartList[index]),
                    separatorBuilder: (context,index)=>Container(height: .1.h,width: 100.w,color: Colors.grey,),
                    itemCount: GetCartList.length),
                SizedBox(height: 1.h,),
                Row(
                  children: [
                    Text('خدمه التوصيل',style: TextStyle(fontSize: 12.sp,),),
                    Spacer(),
                    if(delivary==0)
                      Text('free',style: TextStyle(fontSize: 12.sp),),
                    if(delivary!=0)
                    Text('${delivary}ج',style: TextStyle(fontSize: 12.sp)),
                  ],
                ),
                if(FoodCubit.get(context).a!=0)
                Row(
                  children: [
                    Text('خصم',style: TextStyle(fontSize: 12.sp,),),
                    Spacer(),
                    Text('${(FoodCubit.get(context).a*Total).round()}ج',style: TextStyle(fontSize: 12.sp)),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: HexColor('#8d2422')),),

                    child: Padding(
                      padding:  EdgeInsets.all(1.h),
                      child: Text('الاجمالي : ${(Total-(a*Total).round())+delivary}ج',textAlign: TextAlign.end,style: TextStyle(color: Colors.blueAccent,fontWeight:FontWeight.bold,fontSize:13.sp ),),
                    )),
              ],
            ),
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Widget Alerting(AddToCart getCartList)=>Column(
    children:
    [
      Row(
        children: [
          Text("${getCartList.num}x", style: TextStyle(fontSize: 12.sp)),
          SizedBox(width: 5.w,),
          Expanded(flex: 2,child: Text("${getCartList.name}", style: TextStyle(fontSize: 12.sp))),
          Spacer(),
          Text("${getCartList.price}ج", style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    ],
  );
  bool? check ;
  GetStatus()
  {
    FirebaseFirestore.instance.collection('online').doc('kmxXeXAPxa88b4EjGSJW').get().then((value)
    {
      check=value.data()!['status'];
      emit(getStatusState());
    });
    emit(getStatusState());
  }

  Future setUserLocation({
    String? name,
    String? phone,
    String? location,
  })
  async {
    UserInformation userinfo = UserInformation(name:name,phone:phone,location:location   );
  await  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('userInformation')
        .doc(FirebaseAuth.instance.currentUser!.uid).set(userinfo.toMap()).then((value)
    {
      emit(setUserLocationState());
    }).catchError((errpr)
    {
      emit(setUserLocationErrorState());
    });
  }

   UserInformation getUserInformation=UserInformation(location: '',phone: '',name: '');
  Future GetUserInformationFunction() async {
    getUserInformation=UserInformation(location: '',phone: '',name: '');
      await FirebaseFirestore.instance.collection('users').doc(
          FirebaseAuth.instance.currentUser!.uid).collection('userInformation').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
        getUserInformation = UserInformation.fromJson(value.data()!);
      }).then((value) {
        emit(getUserLocationState());
      }).catchError((error) {
        emit(getUserLocationErrorState());
      });

  }

  Stream<QuerySnapshot> getUpdatefromdata() {
    return FirebaseFirestore.instance.collection('update').snapshots();
  }

  Stream<QuerySnapshot> delivaryService() {
    return FirebaseFirestore.instance.collection('delivery').snapshots();
  }
    int delivary=0;
  getDelivery()
  {
    FirebaseFirestore.instance.collection('delivery').doc('rl7E1D1LGTCwpJ8niq4Z').get().then((value)
    {
      delivary=value['delivaryService'];
    }).then((value)
    {
      emit(getdeliveryServiceState());
    });
  }

 Future MyOrderss()
  async {
        await   FirebaseFirestore.instance.collection('orderss').doc(
        FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
        myOrder order =myOrder(total:value['total'],time:DateFormat.yMMMMd().add_jm().format(DateTime.now())  );
        await FirebaseFirestore.instance.collection('myOrders').doc().set(order.toMap());
        emit(myOrdersDoneState());
    });
  }

  Stream<QuerySnapshot> StreamgetSlider() {
    return FirebaseFirestore.instance.collection('slider').snapshots();
  }
  
  Future updateInformation({location,name,phone})
  async {
 await   FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('userInformation').doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
        {
          'location':location,
          'name':name,
          'phone':phone,
        }).then((value)
 {
   GetUserInformationFunction();
 });
  }

/*
   getDiscount()
    {
    FirebaseFirestore.instance.collection('discount').doc('6SzG6lx2RZWD3HKSdpgv').get().then((value)
    {
      if(value.data()!['num50']>0||value.data()!['num100']>0||value.data()!['num150']>0||value.data()!['num200']>0)
        {
          if(Total>50&&Total<100)
            a=value.data()!['num50'];
          else if(Total>100&&Total<150)
            a= value.data()!['num100'];
          else if(Total>150&&Total<200)
            a= value.data()!['num150'];
          else if(Total>200)
            a= value.data()!['num200'];
          else a=0;
        }
    }).then((value)
    {
      emit(getDiscountState());
    });
  }

 */
  getDiscount0()
  {
    a=0;
    FirebaseFirestore.instance.collection('discount').doc('6SzG6lx2RZWD3HKSdpgv').get().then((value)
    {
      if(value.data()!['num1']>0||value.data()!['num2']>0||value.data()!['num3']>0||value.data()!['num4']>0)
      {
        if(Total>=value.data()!['text1']&&Total<value.data()!['oby1'])
          a=value.data()!['num1'];
        else if(Total>=value.data()!['text2']&&Total<value.data()!['oby2'])
          a=value.data()!['num2'];
        else if(Total>=value.data()!['text3']&&Total<value.data()!['oby3'])
          a=value.data()!['num3'];
        else if(Total>=value.data()!['text4'])
          a=value.data()!['num4'];
        else a=0;
      }
    }).then((value)
    {
      emit(getDiscountState());
    });
  }

  getDiscount2()
  {
    a=0;
    FirebaseFirestore.instance.collection('discount2').doc('R8mXiG8Un1Kv19JCmHd2').get().then((value)
    {
      if(value.data()!['numOfDiscount']>0)
      {
        if(Total>=value.data()!['numOfDiscount'])
          a=value.data()!['discount2'];
      }
    }).then((value)
    {
      emit(getDiscount2State());
    });
    print(a);
  }
  dynamic a=0;


  int? currentValue=0 ;
  setEndPressed(int value) {
      currentValue = value;
      emit(prograss());
  }

  //upload photo
   File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path) ;
      emit(GetProfileImageSuccessState());
      UploadProfileImage();
    } else {
      print('No image selected.');
      emit(GetProfileImageErrorState());
    }

  }
  //uploadProfileImage

  Future UploadProfileImage() async {
        emit(UploadProfileImageLoadingState());
   await firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}').
    putFile(profileImage!).then((value) {
      value.ref.getDownloadURL().then((value) async {
       FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({'image':value});
        emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }
  Stream<QuerySnapshot> gET() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  GetProfileImageStream()
  {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }
  bool? isUpdated;
  bool? emailAndPasswordIsUpdated;
  Future updateData({name,phone,email,password,context})
  async {
    isUpdated=false;
    print(isUpdated);
   await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
        {
         'name':name,
          'phone':email,
        });
    isUpdated=true;
   updateEmailAndPassword(phone:phone,password:password,context: context);
  }

  Future updateEmailAndPassword({phone,password,context})
  async {
    emailAndPasswordIsUpdated=false;
    FirebaseAuth.instance.signInWithEmailAndPassword(email: '${getUserData.email}@gmail.com', password:getUserData.password! ).then((value)
    async {
      await FirebaseAuth.instance.currentUser!.updateEmail('${phone}@gmail.com');
      await FirebaseAuth.instance.currentUser!.updatePassword(password);
    }).then((value)
    {
       FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
          {
            'email':phone,
            'password':password,
          });
       emailAndPasswordIsUpdated=true;
       defaultToast(context: context,message: 'تم التحديث بنجاح',color: Colors.black);
  //     Fluttertoast.showToast(msg: 'تم التحديث بنجاح');
    }).catchError((error)
    {
      print(error.code);
      if(error.code.toString()=='email-already-in-use')
        defaultToast(context: context,message: 'رقم الموبايل مستخدم من قبل',color: Colors.black);
  //      Fluttertoast.showToast(msg: 'رقم الموبايل مستخدم من قبل');
      if(error.code.toString()=='weak-password')
        defaultToast(context: context,message: 'كلمه المرور ضعيفه',color: Colors.black);
    //    Fluttertoast.showToast(msg: 'كلمه المرور ضعيفه');
    });
  }

 Future setIsOkFunction()
  async {
    orderIsOk =true;
  await FirebaseFirestore.instance.collection('orderss').doc(FirebaseAuth.instance.currentUser!.uid).update({'orderIsOk': orderIsOk});
  }

  updateCarttoUser({name,price,num,text})
  {
   FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('addToCart').get().then((value)
     {
      value.docs.clear();
     if(value.docs.length==0)
       {
         addToCartFunction(name: name,price: price,num:number,text: text,);
         print('isEmpty');
       }
      if(value.docs.length!=0) {
        value.docs.clear();
        /*
       value.docs.forEach((element)
       async {
         if(element['name']==name)
         {
               element.reference.update({'price':element['price']+price,'num':element['num']+num});
                 print('==name');

         }
         if(element['name']!=name)
           {
     await           addToCartFunction(name: name,price: price,num:number,text: text);
           print('!=name');

           }
       });

        */
        for (var element in value.docs) {
          if (element['name'] == name)
            element.reference.update({
              'price': element['price'] + price,
              'num': element['num'] + num
            });
          else if (element['name']!=name)
            for (var elementt in value.docs)
            {
              if(name!=elementt['name'])
            addToCartFunction(name: name, price: price, num: number, text: text);
              break;
            }
          break;
        }
      }
   });
 }

  updateCarttooUser({name,price,num,text})
  {
   FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('addToCart').get().then((value)
   {
     if(value.docs.isEmpty)
     {
       addToCartFunction(name: name,price: price,num:number,text: text,);
     }
     if(value.docs.isNotEmpty)
     {
       for(var element in value.docs)
       {
         if(element['name']==name)
         {
           element.reference.update({
             'price': element['price'] + price,
             'num': element['num'] + num
           });
           break;
         }
         else if (element['name']!=name)
           addToCartFunction(name: name,price: price,num:number,text: text,);
         break;
       };
     }
   });
  }


  Future ShowDialogForUpdating(BuildContext context,
      {EmailController, NameController, PhoneController, PasswordController,}) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء",
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("تحديث",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
      ),
      onPressed: () async {
        updateData(name:NameController,phone: PhoneController,email: EmailController,password: PasswordController,context: context).then((value)
        {
          Navigator.pop(context);
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
      content: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("هل تريد تحديث البيانات ؟",
            style: TextStyle(fontSize: 15.sp,)),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Future ShowDialogForLogin(BuildContext context,) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء",
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("تسجيل الدخول",
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
      ),
      onPressed: () async {
       NavigateAndFinsh(context, LoginScreen());
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
      content: Padding(
        padding: EdgeInsets.only(right: 2.h, left: 2.h),
        child: Text("من فضلك قم بتسجيل الدخول ",
            style: TextStyle(fontSize: 15.sp,)),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Stream<QuerySnapshot> haveOrder() {
    return FirebaseFirestore.instance.collection('orderss').snapshots();
  }
}