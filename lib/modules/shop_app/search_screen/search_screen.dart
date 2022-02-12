import 'package:ex2/modules/shop_app/search_screen/shop_search_cubit/search_cubit.dart';
import 'package:ex2/modules/shop_app/search_screen/shop_search_cubit/states.dart';
import 'package:ex2/shared/components/components_todoapp.dart';
import 'package:ex2/shared/components/shopapp_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var Formkey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Search',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            body: Form(
              key: Formkey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Search is empty';
                        }
                      },
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      onChanged: (String? text) {
                        if (Formkey.currentState!.validate()) {
                          ShopSearchCubit.get(context).search(text!);
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Search'),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is ShopSearchLoadState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is ShopSearchSuccessState)
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.grey[200],
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                               buildListProduct(
                                        ShopSearchCubit.get(context)
                                            .model
                                            .data!
                                            .data![index],
                                        context,
                                        isOldPrice: false),

                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: ShopSearchCubit.get(context)
                                .model
                                .data!
                                .data!
                                .length),
                      ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
