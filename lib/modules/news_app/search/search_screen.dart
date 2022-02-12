import 'package:ex2/layout/cubit_NewApp/cubit.dart';
import 'package:ex2/layout/cubit_NewApp/states.dart';
import 'package:ex2/shared/components/components_todoapp.dart';
import 'package:ex2/shared/components/news_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class searchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list =NewsCubit.get(context).search;
         return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Search must not be empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        NewsCubit.get(context).getSearch(value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: list.length > 0
                        ? ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildArticleItem(list[index], context),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: list.length)
                        :Container(),
                  ),
                ],
              ),
            );
        });
  }
}
