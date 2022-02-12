import 'package:bloc/bloc.dart';
import 'package:ex2/models/shop_app/search_model.dart';
import 'package:ex2/modules/shop_app/search_screen/shop_search_cubit/states.dart';
import 'package:ex2/shared/components/constants.dart';
import 'package:ex2/shared/network/end_points.dart';
import 'package:ex2/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(ShopSearchInitState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);
  late SearchModel model;
void search(String Text){
  emit(ShopSearchLoadState());

  DioHelper.postData(url: SEARCH, data: {'text':Text},token: token).then((value) {
    model=SearchModel.fromJson(value.data);
  emit(ShopSearchSuccessState());
}).catchError((error){
    print(error.toString());
      emit(ShopSearchErrorState(error));

  });
}

}
