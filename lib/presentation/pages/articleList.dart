import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/domain/repository/abstractArticlesRepo.dart';
import 'package:newsapp/presentation/bloc/articleBloc.dart';
import 'package:newsapp/data/repository/concreteArticleRepo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:newsapp/presentation/bloc/bookmarkBloc.dart';
import 'package:newsapp/presentation/widgets/articleListWidget.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {

  late final ArticleBloc _bloc = BlocProvider.of<ArticleBloc>(context);
  late final StreamSubscription<List<ConnectivityResult>> subscription;
  final Tabs = ["Politics","Technology","Science","War"];

  @override
  void initState() {
    _bloc.add(OnGettingArticleEvent(Tabs[0]));
    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      print(result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi));
    });
    super.initState();
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  List<Tab> crateTabs(){
    List<Tab> tabs = [];
    Tabs.forEach((element) {
      tabs.add(Tab(
        text: element,
      ));
    });
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: Tabs.length,
      child: SafeArea(
        child: Scaffold(
          appBar: TabBar(
            onTap: (index) { _bloc.add(OnGettingArticleEvent(Tabs[index])); },
            dividerColor: Colors.transparent,
            tabs: crateTabs()
          ),
          body: BlocBuilder<ArticleBloc,ArticleState>(
            bloc: _bloc,
            builder: (context, state){
              if (state is SuccessGetArticleState){
                return ArticleListWidget(articles: state.articles ?? [],isLive: true,);
              }
              else{
                return Text("baaad");
              }
            },
          ),
        ),
      ),
    );
  }

}
