import 'package:ex2/models/shop_app/change_favorites_model.dart';
import 'package:ex2/models/shop_app/shop_login_model.dart';

abstract class ShopStates {}
class ShopInitialState extends ShopStates {}
class ShopChangeBottomNavState extends ShopStates {}
class ShopLoadingHomeState extends ShopStates {}
class ShopSuccessHomeState extends ShopStates {}
class ShopErrorHomeState extends ShopStates {}
class ShopSuccessCategoriesState extends ShopStates {}
class ShopErrorCategoriesState extends ShopStates {}
class ShopChangeFavoritesState extends ShopStates {}
class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model ;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopStates {}
class ShopLoadingGetFavoritesState extends ShopStates {}
class ShopSuccessGetFavoritesState extends ShopStates {}
class ShopErrorGetFavoritesState extends ShopStates {}
class ShopLoadingUserDataState extends ShopStates {}
class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates {}
class ShopLoadingUpdateUserDataState extends ShopStates {}
class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}
class ShopErrorUpdateUserDataState extends ShopStates {}