import 'package:bloc/bloc.dart';
import 'package:ex2/layout/cubit_NewApp/states.dart';
import 'package:ex2/modules/news_app/business/businessscreen.dart';
import 'package:ex2/modules/news_app/science/sciencescreen.dart';
import 'package:ex2/modules/news_app/sports/sportscreen.dart';
import 'package:ex2/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  List<Widget> screens = [
    businessScreen(),
    sportScreen(),
    scienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      emit(NewsGetBusinessSuccessState());

      //print(value.data['articles'][0]['title'].toString());
      business = value.data['articles'];
      print(business[0]['title'].toString());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));

      print(error.toString());
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        emit(NewsGetSportsSuccessState());

        //print(value.data['articles'][0]['title'].toString());
        sports = value.data['articles'];
        print(sports[0]['title'].toString());
      }).catchError((error) {
        emit(NewsGetSportsErrorState(error.toString()));

        print(error.toString());
      });
    } else
      emit(NewsGetSportsSuccessState());
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        emit(NewsGetScienceSuccessState());

        //print(value.data['articles'][0]['title'].toString());
        science = value.data['articles'];
        print(science[0]['title'].toString());
      }).catchError((error) {
        emit(NewsGetScienceErrorState(error.toString()));

        print(error.toString());
      });
    } else
      emit(NewsGetScienceSuccessState());
  }
  void getSearch(String value) {


    emit(NewsGetSearchLoadingState());
    search=[];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      emit(NewsGetSearchSuccessState());

      //print(value.data['articles'][0]['title'].toString());
     search = value.data['articles'];
      print(search[0]['title'].toString());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));

      print(error.toString());
    });
  }
}
