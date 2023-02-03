import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/modules/counter/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInetialState());
  //to create object from bloc to be accessed from any place
  static CounterCubit get(context) => BlocProvider.of(context);
  int counter = 1;
  void minus() {
    counter--;
    emit(minusState());
  }

  void Plus() {
    counter++;
    emit(PlusState());
  }
}
