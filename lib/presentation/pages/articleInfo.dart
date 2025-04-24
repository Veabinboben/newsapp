import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/presentation/bloc/bookmarkBloc.dart';
import 'package:newsapp/presentation/bloc/infoBloc.dart';
import 'package:newsapp/presentation/widgets/shimmerWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleInfo extends StatelessWidget {
  ArticleInfo({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final block = BlocProvider.of<InfoBloc>(context);
    final bookmarkblock = BlocProvider.of<BookmarkBloc>(context);
    block.add(CheckExistenceEvent(article));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                imageUrl: article.urlToImage ?? "NO IMAGE",
                placeholder: (context, string) => ShimmerWidget(),
                errorWidget: (context, _, obj) => Image.asset(
                  "assets/defaultImage.png",
                  fit: BoxFit.cover,
                  height: 120,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        article.title ?? "NO TITLE",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "${article.source!.name ?? "NO NAME"} | ${article.publishedAt != null ? formatDate(article.publishedAt!) : "NO DATE"}"),
                      Text("Written by ${article.author ?? " unknown author"}"),
                    ],
                  )),
                  BlocBuilder<InfoBloc, InfoState>(
                      bloc: block,
                      builder: (context, state) {
                        if (state is CheckedExistenceState &&
                            state.present == true) {
                          return IconButton(
                              onPressed: () {
                                bookmarkblock.add(DeleteBookmarkEvent(article));
                                block.add(CheckExistenceEvent(article));
                              },
                              icon: const Icon(Icons.bookmark_remove));
                        } else {
                          return IconButton(
                              onPressed: () {
                                bookmarkblock.add(SaveBookmarkEvent(article));
                                block.add(CheckExistenceEvent(article));
                              },
                              icon: const Icon(Icons.bookmark_add));
                        }
                      }),
                ],
              ),
            ),
            const Divider(),
            //Text(article.content != null ? truncateContent(article.content!) : "NO CONTENT"),
            Text(article.description ?? "NO DESCRIPTION"),
            const Spacer(),
            TextButton(
                onPressed: () {
                  _launchUrl(article.url ?? "No URL");
                },
                child: Text("Read Full at ${article.url ?? "NO URL"}"))
          ],
        ),
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMM d – kk:mm a').format(date);
  }

  void _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  String truncateContent(String content) {
    return content.substring(0, content.indexOf('['));
  }
}
