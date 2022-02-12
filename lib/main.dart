import 'package:bloc/bloc.dart';
import 'package:ex2/layout/cubit_todoapp/cubit_todoapp.dart';
import 'package:ex2/layout/social_app/cubit/social_cubit.dart';
import 'package:ex2/layout/social_app/social_layout.dart';
import 'package:ex2/modules/social_app/login/social_login_screen.dart';
import 'package:ex2/shared/components/constants.dart';
import 'package:ex2/shared/network/local/cache_helper.dart';
import 'package:ex2/shared/network/remote/dio_helper.dart';
import 'package:ex2/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/blocobserver_todoapp/BlocObserver_todoapp.dart';
import 'layout/cubit_NewApp/cubit.dart';
import 'layout/cubit_todoapp/states_todoapp.dart';
import 'layout/shop_app/cubit/cubit.dart';

void main() async {
  //بيتأكد ان الميثودس خلصت وبعد كدا بيفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });


  bool? isDark = CacheHelper.getData(key: 'isDark');
  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
   //token = CacheHelper.getData(key: 'token') ?? '';
   uID = CacheHelper.getData(key: 'uID') ?? '';
  Widget widget;

  if (uID != '')
    widget = SocialLayout();
  else
    widget = LoginSocialScreen();

  /*
  if (onBoarding != null) {
    if (token != '') {
      widget = ShopLayout();
    } else
      widget = ShopLoginScreen();
  } else
    widget = OnBoardingScreen();
  */
  runApp(
    MyApp(
      isDark ?? false,
      widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  bool isDark;
  Widget startWidget;


  MyApp(this.isDark, this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(create: (context) => socialCubit()..getUserData()..getPosts()),
        BlocProvider(
            create: (context) => AppCubit()..changeMode(fromShared: isDark)),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getcategoriesData()
              ..getcatefavoriteData()
              ..getUserData()),
      ],
      child: BlocConsumer<AppCubit, appStates>(
        listener: (BuildContext context, appStates state) {},
        builder: (BuildContext context, appStates state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lighttheme,
          darkTheme: darktheme,
          themeMode:
              AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home:startWidget,
        ),
      ),
    );
  }
}
