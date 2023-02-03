import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/layout/shop_lyout/cubit/states.dart';
import 'package:my_udemy_apps/modules/shope_app/categories/categories_screen.dart';
import 'package:my_udemy_apps/modules/shope_app/favorites/favorites_screen.dart';
import 'package:my_udemy_apps/modules/shope_app/products/products_screen.dart';
import 'package:my_udemy_apps/modules/shope_app/settings/settings_screen.dart';
import 'package:my_udemy_apps/shared/component/constant.dart';
import 'package:my_udemy_apps/shared/network/end_point/end_point.dart';
import 'package:my_udemy_apps/shared/network/remote/dio_helper.dart';

import '../../../models/shop_model/change_favorites_model.dart';
import '../../../models/shop_model/shop_categories_model.dart';
import '../../../models/shop_model/shop_favorites_model.dart';
import '../../../models/shop_model/shop_home_model.dart';
import '../../../models/shop_model/shop_login_model.dart';
import '../../../modules/shope_app/search/search_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currenIndex = 0;
  void changeNavBar(int index) {
    currenIndex = index;
    emit(ShopChangeNavBarState());
  }

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    // const SearchScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> BottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Products',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];
  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(
            url: Home,
            //we will take the token to check favorite products
            token: token!)
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText('output${homeModel!.data!.products[0].name.toString()}');
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.in_favorites!,
        });
        //   print('my favorites is${favorites.toString()}');
      });
      emit(ShopSuccessHomeState());
    }).catchError((onError) {
      print('my error:${onError.toString()}');
      emit(ShopErrorHomeState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
            url: GET_CATEGORIES,
            //we will take the token to check favorite products
            token: token!)
        .then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((onError) {
      print('the error of categoriesModel :${onError.toString()}');
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changefavorites;
  void changeFavorites(int productId) {
    //we will use product is to change the favorite status
    favorites[productId] = !favorites[productId]!;
    emit(ShopLoadingFavoritesState());
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: GET_FAVORITES,
      data: {'product_id': productId},
      token: token!,
    ).then((value) {
      changefavorites = ChangeFavoritesModel.fromJson(value.data);
      //print('changefavorites${value.data.toString()}');

      if (!changefavorites!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        GetFavoritesData();
      }

      emit(ShopSuccessChangeFavoritesState(changefavorites!));
      //  print('the massege is: ${changefavorites!.message}');
    }).catchError((onError) {
      print('my error in change:${onError.toString()}');
      favorites[productId] = !favorites[productId]!;
      print('the massege is: ${changefavorites!.message}');
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void GetFavoritesData() {
    DioHelper.getData(
      url: GET_FAVORITES,
      token: token!,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText('all data ${favoritesModel}');
      emit(ShopSuccessFavoritesState());
    }).catchError((onError) {
      print('error to get favorites :${onError}');
      emit(ShopErrorFavoritesState());
    });
  }

  ShopLoginModel? shopLoginModel;
  void GetUsersData() {
    DioHelper.getData(
      url: GET_PROFILE,
      token: token!,
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      printFullText('all data ${value.data.toString()}');
      emit(ShopSuccesUserState());
    }).catchError((onError) {
      print('user error :${onError}');
      emit(ShopErrorUserState());
    });
  }

  void UpdateUsersData({
    required name,
    required email,
    required phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(url: UpdateProfile, token: token!, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value.data);
      printFullText('all data ${value.data.toString()}');
      emit(ShopSuccesUpdateUsertState(shopLoginModel!));
    }).catchError((onError) {
      print('user error :${onError}');
      emit(ShopErrorUpdateUserState());
    });
  }
}
