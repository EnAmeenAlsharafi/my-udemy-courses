import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/modules/shope_app/shop_login/cubit/states.dart';
import 'package:my_udemy_apps/shared/network/end_point/end_point.dart';
import 'package:my_udemy_apps/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_model/shop_login_model.dart';

class shopLoginCubit extends Cubit<ShopLoginState> {
  shopLoginCubit() : super(ShopLoginIntialState());

  static shopLoginCubit get(context) => BlocProvider.of(context);
  IconData suffex = Icons.visibility_off_outlined;
  bool ispassword = true;
  ShopLoginModel? shoploginmodel;
  void changePassword() {
    ispassword = !ispassword;
    suffex =
        ispassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(shopLoginChangePasswordState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(shopLoginLoadingState());
    DioHelper.postData(url: Login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      shoploginmodel = ShopLoginModel.fromJson(value.data);

      emit(shopLoginSuccesState(shoploginmodel!));
    }).catchError((error) {
      print(error);
      emit(shopLoginErrorState(' shop error is ${error.toString()}'));
    });
  }
}
