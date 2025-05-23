import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/presentation/widgets/shimmerWidget.dart';

class ArticleListTile extends StatelessWidget {
  const ArticleListTile({super.key, required this.item});

  final Article item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.source!.name ?? "NULL SOURCE",
            style: const TextStyle(fontSize: 7, fontStyle: FontStyle.italic),
          ),
          Text(
            item.title ?? "NULL TITLE",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      subtitle: Text(
        item.publishedAt != null
            ? getPublishWindows(item.publishedAt!)
            : "NULL TIME",
        style: const TextStyle(fontSize: 7),
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          width: 90,
          height: 70,
          fit: BoxFit.cover,
          imageUrl: item.urlToImage ?? "NO IMAGE",
          placeholder: (context, string) => ShimmerWidget(),
          errorWidget: (context, _, obj) => Image.asset(
            "assets/defaultImage.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () => context.go('/news/full', extra: item),
      //onTap:  () => BlocProvider.of<BookmarkBloc>(context).add(SaveBookmarkEvent(item)),
    );
  }

  String getPublishWindows(String rawDate) {
    DateTime time = DateTime.parse(rawDate);
    DateTime now = DateTime.now();
    final diff = now.difference(time);
    if (diff.inHours < 24) {
      return "${diff.inHours.toString()}h";
    } else {
      return "${diff.inDays.toString()}d";
    }
  }
}
