import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/shared/component/component.dart';
import 'package:my_udemy_apps/shared/cubit/cubit.dart';
import 'package:my_udemy_apps/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import '../../shared/component/constant.dart';

class validate extends StatelessWidget {
  validate({Key? key}) : super(key: key);

  @override
  @override
  @override
  var scaffoldkey = GlobalKey<ScaffoldState>();
  //we use formkey to validate form
  var formkey = GlobalKey<FormState>();

  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  Future? selectedTime;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // .. means we create object from AppCubit and use it
      create: (context) => AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabase) {}
          //create object from AppCubit
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              centerTitle: true,
              title: Text(cubit.titles[cubit.curentindex]),
            ),
            //conditionalBuilder use to build widget base on condition to avoid using implicit condition such as if
            body: ConditionalBuilder(
                condition: state is! AppGetLoadingDatabase,
                builder: (context) => cubit.screans[cubit.curentindex],
                fallback: (context) => CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.showbottomsheet) {
                  if (formkey.currentState!.validate()) {
                    cubit.InsertDatabase(
                        title: titlecontroller.text,
                        date: datecontroller.text,
                        time: timecontroller.text,
                        context: context);
                  }
                } else {
                  scaffoldkey.currentState!
                      .showBottomSheet((context) => Container(
                            width: double.infinity,
                            color: Colors.grey[100],
                            padding: EdgeInsets.all(20),
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                      controller: titlecontroller,
                                      type: TextInputType.text,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'please enter title';
                                        }
                                        ;
                                        return null;
                                      },
                                      label: 'task',
                                      prefix: Icons.title),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  defaultFormField(
                                      controller: titlecontroller,
                                      type: TextInputType.text,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'please enter title';
                                        }
                                        ;
                                        return null;
                                      },
                                      label: 'task',
                                      prefix: Icons.title),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  defaultFormField(
                                      controller: titlecontroller,
                                      type: TextInputType.text,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'please enter title';
                                        }
                                        ;
                                        return null;
                                      },
                                      label: 'task',
                                      prefix: Icons.title),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  defaultFormField(
                                      controller: timecontroller,
                                      type: TextInputType.datetime,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'please pick a time';
                                        }

                                        return null;
                                      },
                                      label: 'time',
                                      prefix: Icons.watch_later_outlined,
                                      onTap: () {
                                        showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        ).then((value) {
                                          timecontroller.text =
                                              value!.format(context).toString();
                                        });
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  defaultFormField(
                                      controller: datecontroller,
                                      type: TextInputType.datetime,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'please pick a date';
                                        }

                                        return null;
                                      },
                                      label: 'date',
                                      prefix: Icons.calendar_today,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2023, 7, 29),
                                        ).then((value) {
                                          if (value != null) {
                                            datecontroller.text =
                                                DateFormat.yMMMd()
                                                    .format(value);
                                          }
                                        });
                                      }),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changeBottomSheet(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheet(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(
                cubit.fabicon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.curentindex,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  cubit.ChangeNavBar(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: 'Archive')
                ]),
          );
        },
      ),
    );
  }
}
