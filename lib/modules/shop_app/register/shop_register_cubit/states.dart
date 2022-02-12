
import 'package:ex2/models/shop_app/shop_login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitState extends ShopRegisterStates {}

class ShopRegisterLoadState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel shopModel;
  ShopRegisterSuccessState(this.shopModel);

}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);

}
class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}
