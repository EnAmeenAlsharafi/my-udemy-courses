// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_udemy_apps/layout/news_app/cubit/cubit.dart';
import 'package:my_udemy_apps/layout/news_app/cubit/states.dart';
import 'package:my_udemy_apps/layout/news_app/news_layout.dart';
import 'package:my_udemy_apps/layout/shop_lyout/shop_lyout.dart';
import 'package:my_udemy_apps/layout/todoapp/todo_layout.dart';
import 'package:my_udemy_apps/modules/counter/counter_screen.dart';
import 'package:my_udemy_apps/modules/home/Home_screan.dart';
import 'package:my_udemy_apps/modules/messanger/Messanger_Screen.dart';
import 'package:my_udemy_apps/modules/login/login_Screeen.dart';
import 'package:my_udemy_apps/modules/shope_app/onboarding/onboardnig_screen.dart';
import 'package:my_udemy_apps/modules/shope_app/search/cubit/cubit.dart';
import 'package:my_udemy_apps/modules/shope_app/shop_login/shop_login_screen.dart';
import 'package:my_udemy_apps/modules/users/user_screen.dart';
import 'package:my_udemy_apps/shared/blocObserver.dart';
import 'package:my_udemy_apps/shared/component/component.dart';
import 'package:my_udemy_apps/shared/component/constant.dart';
import 'package:my_udemy_apps/shared/cubit/cubit.dart';
import 'package:my_udemy_apps/shared/network/local/cash_helper.dart';
import 'package:my_udemy_apps/shared/network/remote/dio_helper.dart';
import 'dart:ui' as ui;

import 'package:my_udemy_apps/shared/style/them_app.dart';

import 'layout/shop_lyout/cubit/cubit.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'modules/social_app/social_login/social_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayoutScreen();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(my_udemy_apps(
    isDark: isDark,
    startwidegt: widget,
  ));
}

class my_udemy_apps extends StatelessWidget {
//  const my_udemy_apps({Key? key}) : super(key: key);

  final bool? isDark;
  final Widget? startwidegt;
  my_udemy_apps({
    this.isDark,
    this.startwidegt,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            // ..getBusinessData()
            // ..getSportData()
            // ..getSciencetData()
            ..changeAppThem(fromshared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..GetFavoritesData()
            ..GetUsersData(),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            // ignore: unused_local_variable
            NewsCubit cubit = NewsCubit.get(context);
            return MaterialApp(
              theme: lightThem,
              darkTheme: darkThem,
              themeMode: ThemeMode.light,
              //cubit.isDark ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: validate(),
              builder: EasyLoading.init(),
            );
          }),
    );
  }
}
