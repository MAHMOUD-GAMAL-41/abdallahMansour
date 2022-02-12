import 'package:ex2/layout/shop_app/cubit/States.dart';
import 'package:ex2/layout/shop_app/cubit/cubit.dart';
import 'package:ex2/models/shop_app/favorite_model.dart';
import 'package:ex2/shared/components/components_todoapp.dart';
import 'package:ex2/shared/components/shopapp_components.dart';
import 'package:ex2/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => ShopCubit.get(context).favoriteModel != null
          ? Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.grey[200],
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      state is! ShopErrorGetFavoritesState
                          ? buildListProduct(
                              ShopCubit.get(context)
                                  .favoriteModel!
                                  .data
                                  .data[index]
                                  .product,
                              context)
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 100,
                                    color: Colors.black26,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Your favorites is empty',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black26,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount:
                      ShopCubit.get(context).favoriteModel!.data.data.length),
            )
          : Center(
        child: Column(
          children: [
            Icon(
              Icons.favorite,
              size: 100,
              color: Colors.black26,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Your favorites is empty',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
