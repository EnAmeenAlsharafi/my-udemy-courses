import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/layout/news_app/cubit/cubit.dart';
import 'package:my_udemy_apps/shared/component/component.dart';

import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  // const SearchScreen({Key? key}) : super(key: key);
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, satte) {},
        builder: (context, satte) {
          var artical = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                      controller: controller,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'please search ';
                        }
                        return null;
                      },
                      onChange: (value) {
                        NewsCubit.get(context).getSearchData(value);
                      },
                      label: 'search',
                      prefix: Icons.search),
                ),
                ArticalBuilder(artical, context, isSearch: true),
              ],
            ),
          );
        });
  }
}
