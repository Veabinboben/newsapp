import 'package:dio/dio.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/domain/repository/abstractArticlesRepo.dart';
import 'package:newsapp/domain/repository/abstractCachedArticleRepo.dart';

part 'articleEvent.dart';
part 'articleState.dart';

class ArticleBloc extends Bloc<ArticleEvent,ArticleState>{
  final AbstractArticlesRepo repo;
  final AbstractCachedArticlesRepo cachedRepo;


  ArticleBloc({required this.repo, required this.cachedRepo}): super(LoadingGetArticleState()){
    on<OnGettingArticleEvent>(_onGettingArticleEvent);
    on<OnAppendArticleEvent>(_onAppendArticleEvent);
  }

  _onGettingArticleEvent(OnGettingArticleEvent event, Emitter<ArticleState> emitter) async {
    emitter(LoadingGetArticleState());
    try {
      Map<String, dynamic> queries = Map<String, dynamic> ();
      queries["q"] = event.theme;
      queries["pageSize"] = event.pageSize;
      queries["page"] = event.page;
      final res = await repo.getArticles(queries);
      if (res.isNotEmpty) {
        cachedRepo.saveCachedArticles(res, event.theme);
      }
      emitter(SuccessGetArticleState(res,theme: event.theme, page: event.page, pageSize: event.pageSize));
    } on DioException {
      final res = await cachedRepo.getCachedArticles(event.theme);
      emitter(SuccessGetCachedArticleState(res,theme: event.theme, page: event.page, pageSize: event.pageSize));
    }
    catch(e){
      emitter(ErrorGetArticleState(e.toString()));
    }
  }

  _onAppendArticleEvent(OnAppendArticleEvent event, Emitter<ArticleState> emitter) async {
    var prev_res = state.articles ?? [];
    try {
      Map<String, dynamic> queries = Map<String, dynamic>();
      queries["q"] = state.theme;
      queries["pageSize"] = state.pageSize;
      queries["page"] = state.page + 1;
      final res = await repo.getArticles(queries);
      prev_res.addAll(res);
      emitter(SuccessGetArticleState(prev_res,theme: state.theme, page: state.page+1, pageSize: state.pageSize));
    }
    catch(e){
      emitter(ErrorGetArticleState(e.toString()));
    }
  }

}