import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/layout/shop_lyout/cubit/cubit.dart';
import 'package:my_udemy_apps/layout/shop_lyout/cubit/states.dart';
import 'package:my_udemy_apps/shared/component/component.dart';

import '../../../shared/component/constant.dart';

class SettingsScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('my name:${nameController}');
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ShopSuccesUpdateUsertState) {
          if (state.shopLoginModel.status!) {
            showToast(
                text: '${state.shopLoginModel.message}',
                state: ToastState.SUCCESS);
          } else {
            showToast(
                text: '${state.shopLoginModel.message}',
                state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).shopLoginModel;
        nameController.text = model!.data!.name!;
        phoneController.text = model.data!.phone!;
        emailController.text = model.data!.email!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).shopLoginModel != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'please enter your name';
                        }
                      },
                      label: '',
                      prefix: Icons.person),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'please enter your email';
                        }
                      },
                      label: '',
                      prefix: Icons.email_outlined),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'please enter your phone';
                        }
                      },
                      label: '',
                      prefix: Icons.phone_android_outlined),
                  defaultButton(
                      function: () {
                        Signout(context);
                      },
                      text: 'Logout'),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () {
                        if (formkey.currentState!.validate()) {
                          ShopCubit.get(context).UpdateUsersData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text);
                        }
                      },
                      text: 'Update'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
