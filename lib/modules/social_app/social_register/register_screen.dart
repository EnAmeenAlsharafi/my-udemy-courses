import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/modules/social_app/social_register/cubit/cubit.dart';
import 'package:my_udemy_apps/modules/social_app/social_register/cubit/states.dart';
import 'package:my_udemy_apps/shared/component/constant.dart';

import '../../../shared/component/component.dart';
import '../../../shared/network/local/cash_helper.dart';

class RegisterScreen extends StatelessWidget {
  //const RegisterScreen({Key? key}) : super(key: key);
  var _formKey = GlobalKey<FormState>();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => socialRegisterCubit(),
      child: BlocConsumer<socialRegisterCubit, socialRegisterState>(
        listener: (context, state) {
          if (state is socialRegisterSuccesState) {
            //   if (state.registerModel.status!) {
            //     // print(state.socialloginmodel.message);
            //     CacheHelper.saveData(
            //             key: 'token', value: state.registerModel.data!.token)
            //         .then((value) {
            //       token = state.registerModel.data!.token!;
            //       navigateAndFinsh(context, socialLayoutScreen());

            //       print("token is${token}");
            //     });
            //   } else {
            //     print(state.registerModel.message);
            //     showToast(
            //         text: '${state.registerModel.message}',
            //         state: ToastState.ERROR);
            //   }
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'Register now to brose our hos offers',
                        //we use copyWith to change the color of the text
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      SizedBox(height: 16),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          label: 'full name',
                          prefix: Icons.person),
                      SizedBox(height: 16),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone';
                            }
                            return null;
                          },
                          label: 'phone number',
                          prefix: Icons.phone_android_outlined),
                      defaultFormField(
                          controller: _emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          label: 'email',
                          prefix: Icons.email_outlined),
                      defaultFormField(
                          controller: _passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: socialRegisterCubit.get(context).suffex,
                          isPassword:
                              socialRegisterCubit.get(context).ispassword,
                          suffixPressed: () {
                            socialRegisterCubit.get(context).changePassword();
                          },
                          onSubmit: (value) {
                            if (_formKey.currentState!.validate()) {
                              // socialRegisterCubit.get(context).userRegister(
                              //       email: _emailController.text,
                              //       password: _passwordController.text,
                              //       name: nameController.text,
                              //       phone: phoneController.text,
                              //     );
                            }
                          },
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          label: 'password',
                          prefix: Icons.lock_outlined),
                      SizedBox(height: 16),
                      ConditionalBuilder(
                        condition: state is! socialRegisterLoadingState,
                        builder: (context) => defaultButton(
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                // socialRegisterCubit.get(context).userRegister(
                                //       email: _emailController.text,
                                //       password: _passwordController.text,
                                //       name: nameController.text,
                                //       phone: phoneController.text,
                                //     );
                              }
                            },
                            text: 'Register'),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
