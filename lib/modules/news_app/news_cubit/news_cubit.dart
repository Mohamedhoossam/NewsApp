import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/news_app/business_screen.dart';
import 'package:news/modules/news_app/news_cubit/news_states.dart';
import 'package:news/modules/news_app/science_screen.dart';
import 'package:news/modules/news_app/sports_screen.dart';
import 'package:news/network/local_network.dart';
import 'package:news/network/remotely_network.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(InitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<BottomNavigationBarItem> list=[
    const BottomNavigationBarItem(icon:Icon(Icons.business) ,label:'business'),
    const BottomNavigationBarItem(icon:Icon(Icons.sports_tennis) ,label:'sports'),
    const BottomNavigationBarItem(icon:Icon(Icons.science_outlined) ,label:'science'),
  ];
  void getIndex(index){
    currentIndex=index;
    emit(NewsStateGetIndex());
  }

  List<Widget> screens=[
     BusinessScreen(),SportsScreen(), ScienceScreen(),
  ];
  List<Text> newScreenName=[
    const Text(
      ' Business News',
    ),
    const  Text(
      ' Sport News',
    ),
    const Text(
      ' Science News',
    ),

  ];
  bool isDark=false;

  void darkMode({bool? sharedPreferences,}){
    if(sharedPreferences!=null) {
      isDark=sharedPreferences;
    } else {
      isDark=!isDark;
    }
     CacheHelper.putBool(key: 'isDark', isDark: isDark).then((value) {
       emit(NewsStateGetDarkMode());

     });

  }

  List<dynamic> business=[];
  Future getBusiness() async{
    DioHelper.getDate(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'8dfd934c95d84098b7fdf907366a8502',
        }
    ).then((value) {
      business=value.data['articles'];
      emit(NewsStateGetBusinessSuccess());

    }).catchError((error){
      emit(NewsStateGetBusinessError());
    });
  }


  Future sports1()async{
    Timer(const Duration(seconds: 3), getSports);
  }

  List<dynamic> sports=[];
  Future getSports()async{
    DioHelper.getDate(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey':'8dfd934c95d84098b7fdf907366a8502',
        }
    ).then((value) {
      sports=value.data['articles'];
      emit(NewsStateGetSportsSuccess());

    }).catchError((error){
      emit(NewsStateGetSportsError());
    });
  }

  List<dynamic> science=[];
   Future getScience() async{
    DioHelper.getDate(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'8dfd934c95d84098b7fdf907366a8502',
        }
    ).then((value) {
      science=value.data['articles'];
      emit(NewsStateGetScienceSuccess());

    }).catchError((error){
      print('my error is $error');
      emit(NewsStateGetScienceError());
    });
  }

  List<dynamic> search=[];

  void getSearch(value){
    search=[];
    DioHelper.getDate(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'8dfd934c95d84098b7fdf907366a8502',
        }
    ).then((value) {
      search=value.data['articles'];
      emit(NewsStateGetSearchSuccess());

    }).catchError((error){
      emit(NewsStateGetSearchError());
    });
  }




}