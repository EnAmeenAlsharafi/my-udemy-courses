import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/layout/news_app/cubit/states.dart';
import 'package:my_udemy_apps/shared/network/local/cash_helper.dart';

import '../../../modules/news_app/business/business_screen.dart';
import '../../../modules/news_app/science/science_screen.dart';
import '../../../modules/news_app/sport/sport_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  static NewsCubit get(context) => BlocProvider.of(context);
  NewsCubit() : super(NewsInitialState());
  int curentIndex = 0;
  List<Widget> screen = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomItim = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Settings',
    // ),
  ];
  void ChangeNaveBar(int index) {
    curentIndex = index;
    if (index == 1) getSportData();
    if (index == 2) getSciencetData();
    emit(NewsNavBarState());
  }

  List<dynamic> bussiness = [];
  void getBusinessData() {
    emit(NewsLoadingBusinessState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '5964f5a2aff84181b618f0d829873ce1'
      },
    ).then((value) {
      // print(value.data['articles'][0]['title']);
      bussiness = value.data['articles'];
      print(bussiness[0]['title']);
      emit(NewsGetBusinessSuccesState());
    }).catchError((error) {
      print('the error is ${error.toString()}');
      emit(
        NewsGetBusinessErroreState(
          error.toString(),
        ),
      );
    });
  }

  List<dynamic> sports = [];
  void getSportData() {
    emit(NewsLoadingSportState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headLines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '5964f5a2aff84181b618f0d829873ce1'
        },
      ).then((value) {
        // print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportSuccesState());
      }).catchError((error) {
        print('the error is ${error.toString()}');
        emit(
          NewsGetSportErroreState(
            error.toString(),
          ),
        );
      });
    } else {
      emit(NewsLoadingSportState());
    }
  }

  List<dynamic> science = [];
  void getSciencetData() {
    emit(NewsLoadingScienceState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headLines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '5964f5a2aff84181b618f0d829873ce1'
        },
      ).then((value) {
        // print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccesState());
      }).catchError((error) {
        print('the error is ${error.toString()}');
        emit(
          NewsGetScienceErroreState(
            error.toString(),
          ),
        );
      });
    } else {
      emit(NewsLoadingScienceState());
    }
  }

  List<dynamic> search = [];
  void getSearchData(String value) {
    emit(NewsLoadingSearchState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {'q': '$value', 'apiKey': '5964f5a2aff84181b618f0d829873ce1'},
    ).then((value) {
      // print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccesState());
    }).catchError((error) {
      print('the error is ${error.toString()}');
      emit(
        NewsGetSearchErroreState(
          error.toString(),
        ),
      );
    });
  }

  bool isDark = false;
  void changeAppThem({bool? fromshared}) {
    if (fromshared != null) {
      isDark = fromshared;
      emit(NewsChangeAppTheme());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeAppTheme());
      });
    }
  }
}
