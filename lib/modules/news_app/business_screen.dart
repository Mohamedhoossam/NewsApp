import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/component/component.dart';
import 'package:news/modules/news_app/news_cubit/news_cubit.dart';
import 'package:news/modules/news_app/news_cubit/news_states.dart';
import 'package:news/network/remotely_network.dart';

class BusinessScreen extends StatelessWidget {


  //const BusinessScreen({Key? key}) : super(key: key);
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          NewsCubit cubit =NewsCubit.get(context);
         // RefreshCallback c =NewsCubit.get(context).getBusiness();
          return Scaffold(
              body: screenBuilder(cubit.business,context,key: keyRefresh,refresh:NewsCubit.get(context).getBusiness )
          );
        },

    );
  }
}

