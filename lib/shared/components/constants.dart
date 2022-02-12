// https://newsapi.org/v2/everything?q=tesla&apiKey=4c85c2d939df4a03853e8dc72c2b74ac


// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca




import 'package:ex2/modules/shop_app/login/login_screen.dart';
import 'package:ex2/shared/network/local/cache_helper.dart';
import 'news_components.dart';

void signOut(context){
  CacheHelper.removeDate(key: 'token').then((value){
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}
String token='';
String uID='';


void printFullText(String text){
  final pattern=RegExp('.{1800}');
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}