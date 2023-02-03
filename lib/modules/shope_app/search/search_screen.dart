import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/modules/shope_app/search/cubit/cubit.dart';
import 'package:my_udemy_apps/modules/shope_app/search/cubit/states.dart';
import 'package:my_udemy_apps/shared/component/component.dart';

import '../../../layout/shop_lyout/cubit/cubit.dart';

import '../../../models/shop_model/shop_search_model.dart';
import '../../../shared/style/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var SearchController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: SearchController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'please enter text';
                            }
                            return null;
                          },
                          label: 'search',
                          prefix: Icons.search,
                          onSubmit: (text) {
                            SearchCubit.get(context).Search(text);
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data
                                .length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    mysprator(),
                            itemBuilder: (BuildContext context, int index) =>
                                BuildSearch(
                                    SearchCubit.get(context)
                                        .searchModel!
                                        .data!
                                        .data[index],
                                    context),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

Widget BuildSearch(Product model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 140,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: 140,
                  height: 140.0,
                ),
                // if (model.discount! != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, height: 1.5),
                  ),
                  Spacer(),
                  Row(children: [
                    Text(
                      '${model.price!.toString()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 1.0,
                    ),
                    // if (model.discount! != 0)
                    //   Text(
                    //     '${model.oldPrice!.toString() == null}',
                    //     style: TextStyle(
                    //       fontSize: 12.0,
                    //       color: Colors.grey,
                    //       decoration: TextDecoration.lineThrough,
                    //     ),
                    //   ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                          ShopCubit.get(context).favorites[model.id]!
                              ? defaultColor
                              : Colors.grey[400],
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        color: Colors.white,
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
