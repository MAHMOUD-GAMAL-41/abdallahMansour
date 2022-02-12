import 'package:bloc/bloc.dart';
import 'package:ex2/layout/cubit_todoapp/states_todoapp.dart';
import 'package:ex2/modules/todo_app/archived_todoapp.dart';
import 'package:ex2/modules/todo_app/done_todoapp.dart';
import 'package:ex2/modules/todo_app/tasks_todoapp.dart';
import 'package:ex2/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<appStates> {
  AppCubit() : super(AppInitState());
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  static AppCubit get(context) => BlocProvider.of(context);
  int counter = 0;
  List<Widget> screens = [NewTasksScreen(), doneScreen(), archivedScreen()];
  List<String> titles = ['New tasks', 'done tasks', 'archived tasks'];

  void changeIndex(index) {
    counter = index;
    emit(AppChangeBottomNavBarStete());
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('database Created');
      database
          .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY ,title TEXT ,date TEXT, time TEXT ,status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error when created table ${error.toString()}');
      });
    },
        onOpen: (database) {
      getDataFromDataBase(database);
      print('database opended');
    }).then((value)
    {
      database = value;
      emit(AppCreateDatabaseStete());
    }
    );
  }

  void getDataFromDataBase(database) async {
    doneTasks = [];
    newTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingStete());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else if (element['status'] == 'archived') archivedTasks.add(element);
      });
      emit(AppGetDatabaseStete());
    });
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
          'INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('$value insert Successfully ');
        emit(AppInsertDatabaseStete());
        getDataFromDataBase(database);
      }).catchError((error) {
        print('Error when inserting New Record ${error.toString()}');
      });
    });
  }

  IconData icon = Icons.edit;
  bool isBottomSheetShowen = false;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShowen = isShow;
    icon = icon;
    emit(AppChangeBottomSheetStete());
  }

  void deleteDatabase({required int id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDatabaseStete());
    });
  }

  void updateDatabase({required String status, required int id}) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDatabaseStete());
    });
  }

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeStete());
    }
    else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark)
          .then((value) => emit(AppChangeModeStete()));
    }
  }
}
