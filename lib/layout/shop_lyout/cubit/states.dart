import '../../../models/shop_model/change_favorites_model.dart';
import '../../../models/shop_model/shop_login_model.dart';

abstract class ShopStates {}

class ShopIntialState extends ShopStates {}

class ShopChangeNavBarState extends ShopStates {}

class ShopLoadingHomeState extends ShopStates {}

class ShopSuccessHomeState extends ShopStates {}

class ShopErrorHomeState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopSuccessFavoritesState extends ShopStates {}

class ShopErrorFavoritesState extends ShopStates {}

class ShopLoadingFavoritesState extends ShopStates {}

class ShopSuccesUserState extends ShopStates {}

class ShopErrorUserState extends ShopStates {}

class ShopLoadingUserState extends ShopStates {}

class ShopSuccesUpdateUsertState extends ShopStates {
  final ShopLoginModel shopLoginModel;

  ShopSuccesUpdateUsertState(this.shopLoginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}
