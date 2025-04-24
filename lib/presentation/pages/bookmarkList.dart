import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/presentation/bloc/bookmarkBloc.dart';
import 'package:newsapp/presentation/widgets/articleListWidget.dart';

class BookmarkList extends StatefulWidget {
  const BookmarkList({super.key});

  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  late final BookmarkBloc _bloc = BlocProvider.of<BookmarkBloc>(context);

  @override
  void initState() {
    _bloc.add(OnGettingBookmarkEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<BookmarkBloc, BookmarkState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is SucsessGetBookmarkState) {
            return ArticleListWidget(
              articles: state.articles,
              isLive: false,
            );
          } else {
            return const Text("baaad");
          }
        },
      ),
    );
  }
}
