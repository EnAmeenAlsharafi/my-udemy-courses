import '../../../../models/shop_model/shop_register_model.dart';

abstract class ShopRegisterState {}

class ShopRegisterIntialState extends ShopRegisterState {}

class shopRegisterLoadingState extends ShopRegisterState {}

class shopRegisterSuccesState extends ShopRegisterState {
  final RegisterModel registerModel;

  shopRegisterSuccesState(this.registerModel);
}

class shopRegisterErrorState extends ShopRegisterState {
  final String error;
  shopRegisterErrorState(this.error);
}

class shopRegisterChangePasswordState extends ShopRegisterState {}
