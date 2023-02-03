import '../../../../models/shop_model/shop_login_model.dart';

abstract class ShopLoginState {}

class ShopLoginIntialState extends ShopLoginState {}

class shopLoginLoadingState extends ShopLoginState {}

class shopLoginSuccesState extends ShopLoginState {
  final ShopLoginModel shoploginmodel;

  shopLoginSuccesState(this.shoploginmodel);
}

class shopLoginErrorState extends ShopLoginState {
  final String error;
  shopLoginErrorState(this.error);
}

class shopLoginChangePasswordState extends ShopLoginState {}
