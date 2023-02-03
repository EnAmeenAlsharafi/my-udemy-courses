import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/layout/shop_lyout/cubit/cubit.dart';
import 'package:my_udemy_apps/layout/shop_lyout/cubit/states.dart';
import 'package:my_udemy_apps/models/shop_model/shop_categories_model.dart';
import 'package:my_udemy_apps/shared/component/component.dart';
import 'package:my_udemy_apps/shared/style/colors.dart';

import '../../../models/shop_model/shop_home_model.dart';
import '../../../shared/component/constant.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status!) {
           showToast(text: state.model.message!, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        //في condtional builder نقول له انه لا يوجد بيانات ولا يعمل بيانات بدون بيانات
        //نستخدم ShopModel يفضل استخدام البيانات الثابتة
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => ProductBuilder(
                ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoriesModel!,
                context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
}

Widget ProductBuilder(HomeModel model, CategoriesModel data, context) {
  return SingleChildScrollView(
    //we use BouncingScrollphysics to make the scrollbar bounce when it reaches the end of the list
    physics: BouncingScrollPhysics(),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //we use carousel slider to make the slider of the products
      CarouselSlider(
        //will use the model list banner to show the slider
        //will create a list of images
        items: model.data!.banners
            .map((e) => Image(
                  image: NetworkImage('${e.image}'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ))
            .toList(),
        options: CarouselOptions(
          height: 200.0,
          autoPlay: true,
          //we use aspectRatio to make the slider fit the screen
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          //viewportFraction use to set the size of the slider
          viewportFraction: 1,
          initialPage: 0,
          //enableInfiniteScroll mean that the slider will loop
          enableInfiniteScroll: true,
          reverse: false,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: data.data!.data.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 10,
                ),
                itemBuilder: (BuildContext context, int index) =>
                    BuildCategoties(data.data!.data[index]),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'New Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.grey[300],
        child: GridView.count(
          crossAxisCount: 2,
          //we use shrinkWrap to make the gridview fit the screen
          shrinkWrap: true,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          //we use childAspectRatio to make the gridview fit the screen
          childAspectRatio: 1 / 1.71,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(
              model.data!.products.length,
              (index) =>
                  BuildeGridProduct(model.data!.products[index], context)),
        ),
      )
    ]),
  );
}

Widget BuildeGridProduct(ProductsModel model, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.0, height: 1.5),
                ),
                Row(children: [
                  Text(
                    '${model.price}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 1.0,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.old_price}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor: ShopCubit.get(context).favorites[model.id]!
                        ? defaultColor
                        : Colors.grey,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      color: Colors.white,
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id!);
                        print('the product id is${model.id}');
                      },
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
Widget BuildCategoties(DataModel data) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          width: 100,
          child: Image(
            image: NetworkImage('${data.image}'),
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.cover,
          ),
        ),
        Container(
            width: 100.0,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              data.name!,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
      ],
    );
