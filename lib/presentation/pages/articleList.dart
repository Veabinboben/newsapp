import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/presentation/bloc/articleBloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:newsapp/presentation/widgets/articleListWidget.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  late final ArticleBloc _bloc = BlocProvider.of<ArticleBloc>(context);
  late final StreamSubscription<List<ConnectivityResult>> subscription;
  final tabsList = ["Politics", "Technology", "Science"];

  @override
  void initState() {
    _bloc.add(OnGettingArticleEvent(tabsList[0]));
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      final res = result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi);
      if (res == true) {
        _bloc.add(OnGettingArticleEvent(tabsList[0]));
      }
    });
    super.initState();
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  List<Tab> crateTabs() {
    List<Tab> tabs = [];
    tabsList.forEach((element) {
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
      length: tabsList.length,
      child: SafeArea(
        child: Scaffold(
          appBar: TabBar(
              onTap: (index) {
                _bloc.add(OnGettingArticleEvent(tabsList[index]));
              },
              dividerColor: Colors.transparent,
              tabs: crateTabs()),
          body: BlocBuilder<ArticleBloc, ArticleState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is SuccessGetArticleState ||
                  (state is SuccessGetCachedArticleState &&
                      state.articles!.isNotEmpty)) {
                return ArticleListWidget(
                  articles: state.articles ?? [],
                  isLive: (state is SuccessGetArticleState),
                );
              } else if (state is LoadingGetArticleState) {
                return const Center(
                  child: const CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child:
                      const Text("Could not load. Check internet connection"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
