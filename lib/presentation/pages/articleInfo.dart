import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/presentation/bloc/bookmarkBloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleInfo extends StatelessWidget {
  ArticleInfo({super.key, required this.article});

  Article article;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                imageUrl: article.urlToImage ?? "NO IMAGE",
                placeholder: (context,string) => Icon(Icons.ac_unit),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(child: Text(article.title ?? "NO TITLE")),
                  IconButton(onPressed: (){
                    BlocProvider.of<BookmarkBloc>(context).add(SaveBookmarkEvent(article));
                  }, icon: Icon(Icons.bookmark))
                ],
              ),
            ),
            Divider(),
            Text(article.content != null ? truncateContent(article.content!) : "NO CONTENT"),
            TextButton(onPressed: () {
              _launchUrl(article.url ?? "No URL");
            }, child: Text ("Read Full"))


          ],
        ),
      ),
    );
  }

  void _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  String truncateContent(String content){
    return content.substring(0, content.indexOf('['));
  }

}
