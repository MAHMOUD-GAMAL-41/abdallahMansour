import 'package:ex2/layout/cubit_todoapp/cubit_todoapp.dart';
import 'package:ex2/layout/cubit_todoapp/states_todoapp.dart';
import 'package:ex2/shared/components/components_todoapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, appStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var newTasks = AppCubit.get(context).newTasks;
          return taskBuilder(newTasks: newTasks);
        });
  }
}
