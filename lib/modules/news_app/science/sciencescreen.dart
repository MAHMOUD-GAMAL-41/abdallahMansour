import 'package:ex2/layout/cubit_NewApp/cubit.dart';
import 'package:ex2/layout/cubit_NewApp/states.dart';
import 'package:ex2/shared/components/components_todoapp.dart';
import 'package:ex2/shared/components/news_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class scienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List list = NewsCubit.get(context).science;
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) => list.length > 0
          ? ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildArticleItem(list[index],context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: list.length)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
