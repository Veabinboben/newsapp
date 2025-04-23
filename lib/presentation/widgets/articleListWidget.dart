import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/presentation/bloc/articleBloc.dart';
import 'package:newsapp/presentation/bloc/bookmarkBloc.dart';
import 'package:newsapp/presentation/widgets/articleListTile.dart';

class ArticleListWidget extends StatelessWidget {
  ArticleListWidget({super.key, required this.articles, required this.isLive});

  List<Article> articles;
  bool isLive;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length + (isLive ? 1 : 0)  ,
      itemBuilder: (context,index) {
        if (!isLive || index < articles.length) {
          final item = articles[index];
          return ArticleListTile(item: item,);
        } else {
          return ListTile(
            title: Center(child: Text("Load more..")),
            onTap: () {BlocProvider.of<ArticleBloc>(context).add(OnAppendArticleEvent());},
          );
        }
      }
    );
  }


}
