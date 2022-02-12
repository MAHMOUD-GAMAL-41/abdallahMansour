import 'package:bloc/bloc.dart';
import 'package:ex2/models/shop_app/shop_login_model.dart';
import 'package:ex2/modules/shop_app/register/shop_register_cubit/states.dart';
import 'package:ex2/shared/network/remote/dio_helper.dart';
import 'package:ex2/shared/network/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userRegister({required Email, required Password,required name, required phone}) {
    emit(ShopRegisterLoadState());
    DioHelper.postData(
        url: REGISTER,
        data: {'email': Email, 'password': Password,'name': name, 'phone': phone}).then((value) {
      print("${value.data}");
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
