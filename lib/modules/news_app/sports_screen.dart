import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/component/component.dart';
import 'package:news/modules/news_app/news_cubit/news_cubit.dart';
import 'package:news/modules/news_app/news_cubit/news_states.dart';

class SportsScreen extends StatelessWidget {
  //const ScienceScreen({Key? key}) : super(key: key);
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    List list=[];
    return  BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        NewsCubit cubit =NewsCubit.get(context);
        return Scaffold(
            body: screenBuilder(cubit.sports,context,key: keyRefresh,refresh: NewsCubit.get(context).sports1)
        );
      },
    );
  }
}
