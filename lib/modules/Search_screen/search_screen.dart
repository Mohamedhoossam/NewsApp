
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/component/component.dart';
import 'package:news/modules/news_app/news_cubit/news_cubit.dart';
import 'package:news/modules/news_app/news_cubit/news_states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchControl =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        NewsCubit cubit=NewsCubit.get(context);

        return Scaffold(
          appBar:AppBar(
            title: const Text('search',style: TextStyle(color: Colors.red),),
            centerTitle: true,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefultTextFormFiled(
                    radius: 10.0,
                    control: searchControl,
                    prefix: Icons.search,
                    hintText: 'search',
                    context: context,
                    change: (String value){
                      cubit.getSearch(value);
                    }
                ),
              ),
              Expanded(
                child: screenBuilder1(cubit.search,context,isSearch: true),
              ),
            ],
          ),
        );

      },

    );
  }
}
