import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/modules/counter/cubit/cubit.dart';
import 'package:my_udemy_apps/modules/counter/cubit/states.dart';

class CounterScrean extends StatelessWidget {
  const CounterScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CounterCubit(),
        child: BlocConsumer<CounterCubit, CounterState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('counter Screen'),
              ),
              body: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Text('MINUS')),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('${CounterCubit.get(context).counter}'),
                  ),
                  TextButton(
                    onPressed: () {
                      CounterCubit.get(context).Plus();
                    },
                    child: Text('PLUS'),
                  ),
                ],
              )),
            );
          },
        ));
  }
}
