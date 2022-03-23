abstract class FoodCubitStates {}

class InitialFoodState extends FoodCubitStates {}
class ChangeHorizontalListColor extends FoodCubitStates {}
class ChangeNavBarItemState extends FoodCubitStates {}


//getHorizontalList

class getHorizontalListSuccessState extends FoodCubitStates {}
class getHorizontalListErrorState extends FoodCubitStates {}


//getCheckenList
class getCheckenListSuccessState extends FoodCubitStates {}
class getCheckenListErrorState extends FoodCubitStates {}

//getRecommendedList
class getRecommendedListSuccessState extends FoodCubitStates {}
class getRecommendedListErrorState extends FoodCubitStates {}

//getCrepList
class getCrepListSuccessState extends FoodCubitStates {}
class getCrepListErrorState extends FoodCubitStates {}

//getPizzaList
class getPizzaListSuccessState extends FoodCubitStates {}
class getPizzaListErrorState extends FoodCubitStates {}

//getMeetList
class getMeetListSuccessState extends FoodCubitStates {}
class getMeetListErrorState extends FoodCubitStates {}

//getMashwyat
class getMashwyatSuccessState extends FoodCubitStates {}
class getMashwyatErrorState extends FoodCubitStates {}

//Plus&Minus
class plusSuccessState extends FoodCubitStates {}
class minusSuccessState extends FoodCubitStates {}

//addToCart
class addToCartSuccessState extends FoodCubitStates {}
class addToCartErrorState extends FoodCubitStates {}

//getCart
class getCartLoadingState extends FoodCubitStates {}
class getCartSuccessState extends FoodCubitStates {}
class getCartErrorState extends FoodCubitStates {}

//getTotal
class getTotalSuccessState extends FoodCubitStates {}
class getTotalErrorState extends FoodCubitStates {}

//deleteItemCart
class deleteItemCartLoadingState extends FoodCubitStates {}
class deleteItemCartSuccessState extends FoodCubitStates {}
class deleteItemCartErrorState extends FoodCubitStates {}

//deleteNullErrorINdataBase
class deleteNullSuccessState extends FoodCubitStates {}
class deleteNullErrorErrorState extends FoodCubitStates {}

//getSlider
class getSliderSuccessState extends FoodCubitStates {}
class getSliderErrorState extends FoodCubitStates {}

//makeOrder
class makeOrderLoadingState extends FoodCubitStates {}
class makeOrderSuccessState extends FoodCubitStates {}
class makeOrderErrorState extends FoodCubitStates {}

//updateCart
class updateCartLoadingState extends FoodCubitStates {}
class updateCartSuccessState extends FoodCubitStates {}
class updateCartErrorState extends FoodCubitStates {}

//getOrdersToAdmin
class getOrdersToAdminSuccessState extends FoodCubitStates {}
class getOrdersToAdminErrorState extends FoodCubitStates {}


//changeColorofOrder
class changeColorofOrderState extends FoodCubitStates {}

//deleteOrderByAdmin
class deleteOrderByAdmin extends FoodCubitStates {}
class deleteOrderByAdminErrorState extends FoodCubitStates {}

//changeStatus
class changeStatusState extends FoodCubitStates {}
class changeStatusErrorState extends FoodCubitStates {}

//checkOrders
class checkOrdersState extends FoodCubitStates {}
class checkOrdersErrorState extends FoodCubitStates {}

//updateOrderss
class updateOrdersState extends FoodCubitStates {}

//oneSignal-------------
//getNotify
class getNotiftyState extends FoodCubitStates {}


//pushNotification
class NotifacationLoader extends FoodCubitStates {}
class pushNotificationHandler extends FoodCubitStates {}
class pushNotificationToSomeone extends FoodCubitStates {}
class usersaddtoList extends FoodCubitStates {}
class getCommenterOsUserID extends FoodCubitStates {}
class getCommenterOsUserIDErrorState extends FoodCubitStates {}


//getUserData
class getUserDataState extends FoodCubitStates {}
class getUserDataErrorState extends FoodCubitStates {}

//signOut
class SocialCubitSignOutSuccessState extends FoodCubitStates {}
class SocialCubitSignOutErrorState extends FoodCubitStates {}

//makingOrdersOnSameTime
class makingOrdersOnSameTimeSuccessState extends FoodCubitStates {}
class makingOrdersOnSameTimeErrorState extends FoodCubitStates {}


class myOrders extends FoodCubitStates {}

class getOsOfAdminLoadingState extends FoodCubitStates {}
class getOsOfAdminState extends FoodCubitStates {}
class getOsOfAdminErrorState extends FoodCubitStates {}

// login from inboarding screen
class LoginOnboardingLoadingState extends FoodCubitStates {}
class LoginOnboardingSuccessState extends FoodCubitStates {
  LoginOnboardingSuccessState(String uid);
}
class LoginOnboardingErrorState extends FoodCubitStates {
  LoginOnboardingErrorState(String string);
}

class getIdState extends FoodCubitStates {}
class getStatusState extends FoodCubitStates {}
//userInformation
class setUserLocationLoadingState extends FoodCubitStates {}
class setUserLocationState extends FoodCubitStates {}
class setUserLocationErrorState extends FoodCubitStates {}

class getUserLocationState extends FoodCubitStates {}
class getUserLocationErrorState extends FoodCubitStates {}

//getdeliveryService price

class getdeliveryServiceState extends FoodCubitStates {}

class OrderAwaitState extends FoodCubitStates {}


class UpdateUserInformation extends FoodCubitStates {}

class getDiscountState extends FoodCubitStates {}
class getDiscount2State extends FoodCubitStates {}

class prograss extends FoodCubitStates {}
class myOrdersDoneState extends FoodCubitStates {}


//image picker
class GetProfileImageSuccessState extends FoodCubitStates {}
class GetProfileImageErrorState extends FoodCubitStates {}

class UploadProfileImageLoadingState extends FoodCubitStates {}
class UploadProfileImageSuccessState extends FoodCubitStates {}
class UploadProfileImageErrorState extends FoodCubitStates {}

class UpdateDataLoadingState extends FoodCubitStates {}
class UpdateDataSuccessState extends FoodCubitStates {}

class UpdateEmailAndPasswordSuccessState extends FoodCubitStates {}
class UpdateEmailAndPasswordErrorState extends FoodCubitStates {}


class UpdateCartSuccessState extends FoodCubitStates {}
class UpdateCartErrorState extends FoodCubitStates {}

class UpdateLoadingState extends FoodCubitStates {}
class UpdateSuccessState extends FoodCubitStates {}

class updateState extends FoodCubitStates {}
