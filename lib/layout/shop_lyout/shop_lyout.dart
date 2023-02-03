import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/layout/shop_lyout/cubit/cubit.dart';
import 'package:my_udemy_apps/layout/shop_lyout/cubit/states.dart';
import 'package:my_udemy_apps/modules/shope_app/shop_login/shop_login_screen.dart';
import 'package:my_udemy_apps/shared/component/component.dart';
import 'package:my_udemy_apps/shared/network/local/cash_helper.dart';

import '../../modules/shope_app/search/search_screen.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Welcome'),
            actions: [
              IconButton(
                  onPressed: () {
                    NavegateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search_outlined))
            ],
          ),
          body: cubit.screens[cubit.currenIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.BottomItem,
            currentIndex: cubit.currenIndex,
            onTap: (index) {
              cubit.changeNavBar(index);
            },
          ),
        );
      },
    );
  }
}
