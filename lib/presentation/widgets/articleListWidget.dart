import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/presentation/bloc/articleBloc.dart';
import 'package:newsapp/presentation/widgets/articleListTile.dart';

class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget(
      {super.key, required this.articles, required this.isLive});

  final List<Article> articles;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: articles.length + (isLive ? 1 : 0),
        itemBuilder: (context, index) {
          if (!isLive || index < articles.length) {
            final item = articles[index];
            return ArticleListTile(
              item: item,
            );
          } else {
            return ListTile(
              title: const Center(child: Text("Load more..")),
              onTap: () {
                BlocProvider.of<ArticleBloc>(context)
                    .add(OnAppendArticleEvent());
              },
            );
          }
        });
  }
}
