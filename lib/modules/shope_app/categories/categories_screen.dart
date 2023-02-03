import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/layout/shop_lyout/cubit/cubit.dart';
import 'package:my_udemy_apps/layout/shop_lyout/cubit/states.dart';
import 'package:my_udemy_apps/modules/shope_app/products/products_screen.dart';
import 'package:my_udemy_apps/modules/shope_app/shop_login/shop_login_screen.dart';
import 'package:my_udemy_apps/shared/component/component.dart';

import '../../../models/shop_model/shop_categories_model.dart';
import '../../../shared/component/constant.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
          separatorBuilder: (BuildContext context, int index) => mysprator(),
          itemBuilder: (BuildContext context, int index) => BuildingCategories(
              ShopCubit.get(context).categoriesModel!.data!.data[index]),
        );
      },
    );
  }
}

Widget BuildingCategories(DataModel model) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            fit: BoxFit.cover,
            width: 100.0,
            height: 100.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
