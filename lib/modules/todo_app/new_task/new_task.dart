import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/shared/component/component.dart';
import 'package:my_udemy_apps/shared/cubit/cubit.dart';
import 'package:my_udemy_apps/shared/cubit/states.dart';

class New_Task extends StatelessWidget {
  const New_Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //we use Bloc Consumer without creating BlocPovider we can create BlocProvider once
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).Newtasks;
        return listTask(tasks: tasks);
      },
    );
  }
}
