import 'package:flutter/material.dart';
import 'package:my_udemy_apps/shared/component/component.dart';

import '../bim_app/bmi/BimScreen.dart';

class Login_Screen extends StatefulWidget {
  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var fromkey = GlobalKey<FormState>();
  bool ispassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        leading: const Icon(Icons.menu),
        actions: const [Icon(Icons.search)],
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: fromkey,
            child: Column(
              children: [
                const Text(
                  'login',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                    // onFieldSubmitted: (value) {
                    //   print(value);
                    // },
                    //this function print the value at the same time
                    // onChanged: (value) {
                    //   print(value);
                    // },
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email';
                      }
                      return null;
                    },
                    label: 'Email',
                    prefix: Icons.email),
                const SizedBox(
                  height: 15.0,
                ),
                defaultFormField(
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email';
                      }
                      return null;
                    },
                    label: 'password',
                    prefix: Icons.lock,
                    suffix:
                        ispassword ? Icons.visibility : Icons.visibility_off,
                    isPassword: ispassword,
                    suffixPressed: () {
                      setState(() {
                        ispassword = !ispassword;
                      });
                    }),
                const SizedBox(
                  height: 15.0,
                ),
                defaultButton(
                    function: () {
                      if (fromkey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BimScreen()));
                      }
                    },
                    text: 'login'),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text('Dont\'have acount?'),
                    TextButton(onPressed: () {}, child: Text('Register Now'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
