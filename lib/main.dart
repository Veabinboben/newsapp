import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/data/repository/concreteArticleRepo.dart';
import 'package:newsapp/data/repository/concreteBookmarkRepo.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/domain/repository/abstractArticlesRepo.dart';
import 'package:newsapp/domain/repository/abstractBookmarkRepo.dart';
import 'package:newsapp/presentation/bloc/articleBloc.dart';
import 'package:newsapp/presentation/bloc/bookmarkBloc.dart';
import 'package:newsapp/presentation/pages/articleInfo.dart';
import 'package:newsapp/presentation/pages/articleList.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/presentation/pages/bookmarkList.dart';

import 'data/sources/hiveInit.dart';

part 'router.dart';

Future<void> main() async {
  // Init Databases
  await HiveInjector.setup();
  // Run application
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  AbstractArticlesRepo _articleRepo = ArticlesRepo();
  AbstractBookmarkRepo _bookmarkRepo = BookmarkRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ArticleBloc(repo: _articleRepo)),
         BlocProvider(create: (context) => BookmarkBloc(repo: _bookmarkRepo)),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

class NavScaffold extends StatelessWidget {
  const NavScaffold({super.key,required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index,initialLocation: index == navigationShell.currentIndex),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'All',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Bookmarked',
          ),
      ],
    ) ,
    );
  }
}


