import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/modules/social_app/social_login/cubit/states.dart';
import 'package:my_udemy_apps/shared/network/end_point/end_point.dart';
import 'package:my_udemy_apps/shared/network/remote/dio_helper.dart';

class socialLoginCubit extends Cubit<socialLoginState> {
  socialLoginCubit() : super(socialLoginIntialState());

  static socialLoginCubit get(context) => BlocProvider.of(context);
  IconData suffex = Icons.visibility_off_outlined;
  bool ispassword = true;
  // socialLoginModel? socialloginmodel;
  void changePassword() {
    ispassword = !ispassword;
    suffex =
        ispassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(socialLoginChangePasswordState());
  }

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(socialLoginLoadingState());
  //   DioHelper.postData(url: Login, data: {
  //     'email': email,
  //     'password': password,
  //   }).then((value) {
  //     print(value.data);
  //     socialloginmodel = socialLoginModel.fromJson(value.data);

  //     emit(socialLoginSuccesState(socialloginmodel!));
  //   }).catchError((error) {
  //     print(error);
  //     emit(socialLoginErrorState(' social error is ${error.toString()}'));
  //   });
}
