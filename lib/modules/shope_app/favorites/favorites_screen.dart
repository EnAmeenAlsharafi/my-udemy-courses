import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_lyout/cubit/cubit.dart';
import '../../../layout/shop_lyout/cubit/states.dart';
import '../../../shared/component/component.dart';
import '../../../shared/style/colors.dart';
import '../categories/categories_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingFavoritesState,
          builder: (context) => ListView.separated(
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
            separatorBuilder: (BuildContext context, int index) => mysprator(),
            itemBuilder: (BuildContext context, int index) => BuildListProduct(
                ShopCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data[index]
                    .product!,
                context),
          ),
          fallback: (context) => Center(),
        );
      },
    );
  }
}
