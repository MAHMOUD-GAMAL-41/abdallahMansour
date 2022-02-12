import 'package:ex2/layout/shop_app/cubit/States.dart';
import 'package:ex2/layout/shop_app/cubit/cubit.dart';
import 'package:ex2/models/shop_app/categories_model.dart';
import 'package:ex2/shared/components/components_todoapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (contex, state) {},
      builder: (context, state) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(10.0),
              child: buildCatItem(
                  ShopCubit.get(context).categoriesModel!.data.data[index])),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length),
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 85,
              height: 85,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
