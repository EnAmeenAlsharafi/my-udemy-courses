import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/modules/shope_app/register/cubit/states.dart';
import 'package:my_udemy_apps/shared/network/end_point/end_point.dart';
import 'package:my_udemy_apps/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_model/shop_register_model.dart';

class shopRegisterCubit extends Cubit<ShopRegisterState> {
  shopRegisterCubit() : super(ShopRegisterIntialState());

  static shopRegisterCubit get(context) => BlocProvider.of(context);
  IconData suffex = Icons.visibility_off_outlined;
  bool ispassword = true;
  RegisterModel? registerModel;
  void changePassword() {
    ispassword = !ispassword;
    suffex =
        ispassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(shopRegisterChangePasswordState());
  }

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(shopRegisterLoadingState());
    DioHelper.postData(url: Register, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }).then((value) {
      print(value.data);
      registerModel = RegisterModel.fromJson(value.data);

      emit(shopRegisterSuccesState(registerModel!));
    }).catchError((error) {
      print(error);
      emit(shopRegisterErrorState(' shop error is ${error.toString()}'));
    });
  }
}
