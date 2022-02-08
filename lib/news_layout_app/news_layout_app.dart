import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/component/component.dart';
import 'package:news/modules/Search_screen/search_screen.dart';
import 'package:news/modules/news_app/news_cubit/news_cubit.dart';
import 'package:news/modules/news_app/news_cubit/news_states.dart';

class NewsLayoutApp extends StatelessWidget {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        NewsCubit cubit =NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: cubit.newScreenName[cubit.currentIndex],
            actions:  [
              IconButton(onPressed:(){
                cubit.search=[];
                navigateTo(context, SearchScreen());
              }, icon:const Icon(Icons.search) ),
              IconButton(onPressed:(){cubit.darkMode();}, icon:const Icon(Icons.brightness_4) ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.list,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.getIndex(index);
            },

          ),
          body:cubit.screens[cubit.currentIndex] ,
        );
      },

    );
  }
}
