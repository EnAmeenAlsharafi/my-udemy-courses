// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/layout/news_app/cubit/cubit.dart';
import 'package:my_udemy_apps/layout/news_app/cubit/states.dart';
import 'package:my_udemy_apps/shared/component/component.dart';
import 'package:my_udemy_apps/shared/network/remote/dio_helper.dart';

import '../../modules/news_app/search/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: ((context, state) {}),
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'App News',
              ),
              //    centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    NavegateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: () {
                    cubit.changeAppThem();
                  },
                )
              ],
            ),
            body: cubit.screen[cubit.curentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItim,
              onTap: (index) {
                cubit.ChangeNaveBar(index);
              },
              currentIndex: cubit.curentIndex,
            ),
          );
        });
  }
}
