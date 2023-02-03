import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_udemy_apps/shared/component/constant.dart';
import 'package:my_udemy_apps/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/todo_app/archived_task/archive_task.dart';
import '../../modules/todo_app/done_task/done_task.dart';
import '../../modules/todo_app/new_task/new_task.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit()
      : super(
          AppinitialState(),
        );

  static AppCubit get(context) => BlocProvider.of(context);
  int curentindex = 0;

  List<Widget> screans = [
    New_Task(),
    Done_Task(),
    Archive_Task(),
  ];
  List<String> titles = [
    'New Task',
    'Done Task',
    'Archive Task',
  ];
  void ChangeNavBar(int index) {
    curentindex = index;
    emit(AppChangeBottomNavBar());
  }

  bool showbottomsheet = false;
  IconData fabicon = Icons.edit;
  Database? database;
  List<Map> Newtasks = [];
  List<Map> DoneTasks = [];
  List<Map> ArchiveTasks = [];
  void CreateDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE TASKS(ID INTEGER PRIMARY KEY,TITLE TEXT,DATA TEXT,TIME TEXT, STATUS TEXT)')
          .then((value) {})
          .catchError((error) {
        print('${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);

      print('data opend');
    }).then((value) {
      database = value;
      emit(AppInsertDatabase());
    });
  }

  InsertDatabase(
      {required String title,
      required String date,
      required String time,
      required BuildContext context}) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              'insert into tasks(TITLE,DATA,TIME,STATUS) values ("$title","$date","$time","new")')
          .then((value) {
        print('$value  inserted successfully');
        emit(AppInsertDatabase());
        Navigator.pop(context);
        getDataFromDatabase(database);
      }).catchError((error) {
        print(' error when inserted new record${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database) {
    Newtasks = [];
    DoneTasks = [];
    ArchiveTasks = [];
    emit(AppGetLoadingDatabase());
    database!.rawQuery('select * from tasks').then((value) {
      value.forEach((element) {
        if (element['STATUS'] == 'new') {
          Newtasks.add(element);
        } else if (element['STATUS'] == 'done') {
          DoneTasks.add(element);
        } else {
          ArchiveTasks.add(element);
        }
      });
      emit(AppGetDatabase());
    });
  }

  Future deletData(database) async {
    return await database!
        .delete('DELETE FROM tasks WHERE ID=1')
        .then((value) => print('$value data deleted'));
  }

  void changeBottomSheet({
    required bool isShow,
    required IconData icon,
  }) {
    showbottomsheet = isShow;
    fabicon = icon;
    emit(AppChangeBottomsheet());
  }

  void UpdateDatabase({required String status, required int id}) async {
    database!.rawUpdate(
      'UPDATE TASKS SET STATUS=? WHERE ID=?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabase());
    });
  }

  void deleteData({
    required int id,
  }) async {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteFromDatabase());
    });
  }
}
