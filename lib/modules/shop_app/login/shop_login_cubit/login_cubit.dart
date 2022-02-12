import 'package:bloc/bloc.dart';
import 'package:ex2/models/shop_app/shop_login_model.dart';
import 'package:ex2/modules/shop_app/login/shop_login_cubit/states.dart';
import 'package:ex2/shared/network/remote/dio_helper.dart';
import 'package:ex2/shared/network/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitState());



  static ShopLoginCubit get(context) => BlocProvider.of(context);
 late ShopLoginModel loginModel;
  void userLogin({required Email, required Password}) {
    emit(ShopLoginLoadState());
    DioHelper.postData(url: LOGIN, data: {'email': Email, 'password': Password})
        .then((value) {
      print("${value.data}");
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}
