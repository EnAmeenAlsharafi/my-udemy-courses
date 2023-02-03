import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_udemy_apps/modules/social_app/social_login/cubit/cubit.dart';
import 'package:my_udemy_apps/modules/social_app/social_login/cubit/states.dart';
import 'package:my_udemy_apps/shared/component/component.dart';
import 'package:my_udemy_apps/shared/component/constant.dart';
import 'package:my_udemy_apps/shared/network/local/cash_helper.dart';

import '../../shope_app/register/register_screen.dart';

class socialLoginScreen extends StatelessWidget {
  @override
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => socialLoginCubit(),
        child: BlocConsumer<socialLoginCubit, socialLoginState>(
          listener: (context, state) {
            // TODO: implement listener
            // if (state is socialLoginSuccesState) {
            //   if (state.socialloginmodel.status!) {
            //     // print(state.socialloginmodel.message);
            //     CacheHelper.saveData(
            //             key: 'token', value: state.socialloginmodel.data!.token)
            //         .then((value) {
            //       token = state.socialloginmodel.data!.token!;
            //       navigateAndFinsh(context, socialLayoutScreen());

            //       print("token is${token}");
            //     });
            //   } else {
            //     print(state.socialloginmodel.message);
            //     showToast(
            //         text: '${state.socialloginmodel.message}',
            //         state: ToastState.ERROR);
            //   }
            // }
          },
          builder: (context, state) {
            return Scaffold(
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
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(
                            'login now to communicate with your friends ',
                            //we use copyWith to change the color of the text
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          SizedBox(height: 16),
                          defaultFormField(
                              controller: _emailController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your email';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined),
                          SizedBox(height: 16),
                          defaultFormField(
                              controller: _passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: socialLoginCubit.get(context).suffex,
                              isPassword:
                                  socialLoginCubit.get(context).ispassword,
                              suffixPressed: () {
                                socialLoginCubit.get(context).changePassword();
                              },
                              onSubmit: (value) {
                                // if (_formKey.currentState!.validate()) {
                                //   socialLoginCubit.get(context).userLogin(
                                //       email: _emailController.text,
                                //       password: _passwordController.text);
                                // }
                              },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your password';
                                }
                              },
                              label: 'password',
                              prefix: Icons.lock_outline),
                          SizedBox(height: 16),
                          ConditionalBuilder(
                            condition: state is! socialLoginLoadingState,
                            builder: (context) => defaultButton(
                                function: () {
                                  // if (_formKey.currentState!.validate()) {
                                  //   socialLoginCubit.get(context).userLogin(
                                  //       email: _emailController.text,
                                  //       password: _passwordController.text);
                                  // }
                                },
                                text: 'Login'),
                            fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Text('Don\'t have an account?',
                                  style: Theme.of(context).textTheme.bodyText1),
                              defualtFunction(
                                  text: 'Regestare',
                                  function: () {
                                    NavegateTo(context, RegisterScreen());
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
            ;
          },
        ));
  }
}
