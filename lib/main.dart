import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/modules/news_app/news_cubit/news_cubit.dart';
import 'package:news/modules/news_app/news_cubit/news_states.dart';
import 'package:news/network/local_network.dart';
import 'package:news/network/remotely_network.dart';
import 'package:news/news_layout_app/news_layout_app.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'news_layout_app/bloc_observer.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await  DioHelper.init();
  await  CacheHelper.init();
  bool? isDark = CacheHelper.getBool(key: 'isDark');
  runApp( NewsApp(isDark??false));
}

class NewsApp extends StatelessWidget {
  // const NewsApp({Key? key}) : super(key: key);

   final bool isDark;
      NewsApp(this.isDark);

//"assets/image/news.png", NewsLayoutApp()
  @override
  Widget build(BuildContext context) {
    Widget splash=SplashScreenView(
      navigateRoute: NewsLayoutApp(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/image/news.png",
      text: "News Of World",
      textType: TextType.TyperAnimatedText,
      textStyle: const TextStyle(
        fontSize: 30.0,

      ),
      colors: const[
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor:Colors.white,
    );
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getBusiness()..getSports()..getScience()..darkMode(sharedPreferences: isDark),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          NewsCubit cubit=NewsCubit.get(context);
          return  MaterialApp(
            theme: ThemeData(

              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                color: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),

              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w600
                ),
              ),

            ),
            darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme:  AppBarTheme(
                  elevation: 0.0,
                  backgroundColor:HexColor('333739'),
                  titleTextStyle: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),

                ),
                scaffoldBackgroundColor: HexColor('333739'),
                textTheme: const TextTheme(
                 bodyText1: TextStyle(
                    color: Colors.white,
                       fontSize: 16.5,
                   fontWeight: FontWeight.w600
          ),
            ),
                bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,

                )

            ),
            themeMode:cubit.isDark?ThemeMode.dark:ThemeMode.light ,
            debugShowCheckedModeBanner: false,
            home: splash,
          );
        },
      ),
    );
  }
}

