import 'package:ex2/layout/cubit_todoapp/cubit_todoapp.dart';
import 'package:flutter/material.dart';

Widget buildTaskItem(
  String title,
  String time,
  String date,
  int id,
  context,
) {
  return Dismissible(
    key: Key(id.toString()),
    onDismissed: (direction) {
      AppCubit.get(context).deleteDatabase(id:id);
    },
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(time),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  date,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
              onPressed: () {
                AppCubit.get(context).updateDatabase(status:'done', id:id);
              }),
          IconButton(
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
              onPressed: () {
                AppCubit.get(context).updateDatabase(status:'archived',id: id);
              }),
        ],
      ),
    ),
  );
}

Widget taskBuilder({required List<Map> newTasks}) => newTasks.length > 0
    ? ListView.separated(
        itemBuilder: (BuildContext context, index) => buildTaskItem(
              newTasks[index]['title'],
              newTasks[index]['time'],
              newTasks[index]['date'],
              newTasks[index]['id'],
              context,
            ),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: newTasks.length)
    : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 100,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey),
            ),
          ],
        ),
      );
Widget myDivider ()=> Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 5,
    color: Colors.grey[300],
  ),
);




