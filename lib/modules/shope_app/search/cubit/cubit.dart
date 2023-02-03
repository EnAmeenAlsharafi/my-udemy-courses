import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/modules/shope_app/search/cubit/states.dart';
import 'package:my_udemy_apps/shared/component/constant.dart';
import 'package:my_udemy_apps/shared/network/end_point/end_point.dart';
import 'package:my_udemy_apps/shared/network/remote/dio_helper.dart';

import '../../../../models/shop_model/shop_search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void Search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: search,
      token: token!,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print('my search${value.data}');
      print('hello${searchModel!.data!.data[2].description}');

      emit(SearchSuccessState());
    }).catchError((onError) {
      print('Search error is${onError.toString()}');
      emit(SearchErrorState());
    });
  }
}
