import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsapp/domain/models/article.dart';
import 'package:newsapp/domain/models/source.dart';
import 'package:newsapp/domain/repository/abstractArticlesRepo.dart';
import 'package:newsapp/domain/repository/abstractBookmarkRepo.dart';

@GenerateMocks([AbstractBookmarkRepo])

import 'domain_tests.mocks.dart';

void main() {
  late Article article;
  late MockAbstractBookmarkRepo  mockBookmarkRepo;

  setUp(() {
    mockBookmarkRepo = MockAbstractBookmarkRepo ();
    article = Article(null, "author", "title", "description", "url", "urlToImage", "publishedAt", "content");
  });

  test('should get articles from the repository', () async {
    when(mockBookmarkRepo.getSavedArticles()).thenAnswer((_) async => [article]);

    final result = await mockBookmarkRepo.getSavedArticles();

    expect(result, [article]);
    verify(mockBookmarkRepo.getSavedArticles()).called(1);
    verifyNoMoreInteractions(mockBookmarkRepo);
  });

  test('should get a specific saved article', () async {
    when(mockBookmarkRepo.getSavedArticle(any)).thenAnswer((_) async => article);

    final result = await mockBookmarkRepo.getSavedArticle(article);

    expect(result, article);
    verify(mockBookmarkRepo.getSavedArticle(article)).called(1);
    verifyNoMoreInteractions(mockBookmarkRepo);
  });

  test('should return null if article is not found', () async {
    when(mockBookmarkRepo.getSavedArticle(any)).thenAnswer((_) async => null);

    final result = await mockBookmarkRepo.getSavedArticle(article);

    expect(result, isNull);
    verify(mockBookmarkRepo.getSavedArticle(article)).called(1);
    verifyNoMoreInteractions(mockBookmarkRepo);
  });

  test('should return empty list if no articles are saved', () async {
    when(mockBookmarkRepo.getSavedArticles()).thenAnswer((_) async => []);

    final result = await mockBookmarkRepo.getSavedArticles();

    expect(result, isEmpty);
    verify(mockBookmarkRepo.getSavedArticles()).called(1);
    verifyNoMoreInteractions(mockBookmarkRepo);
  });
}