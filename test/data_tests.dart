
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:newsapp/data/models/articleResponseDTO.dart';
import 'package:newsapp/data/sources/articleApi.dart'; // Adjust import

@GenerateMocks([Dio])

import 'data_tests.mocks.dart';

void main() {
  late MockDio mockDio;
  late ArticleHttpClient apiClient;

  setUp(() {
    mockDio = MockDio();
    apiClient = ArticleHttpClient(mockDio);
  });

  test('getTopHeadlines returns articles', () async {
    final responseMock = {
      "status": "ok",
      "totalResults": 1,
      "articles": [
        {
          "author": "John",
          "title": "Flutter News!",
          "description": "About Flutter",
          "url": "https://...",
          "urlToImage": "https://...",
          "publishedAt": "2024-04-01",
          "content": "Flutter is awesome!"
        }
      ]
    };

    final response = Response(
      data: responseMock,
      statusCode: 200,
      requestOptions: RequestOptions(path: '/everything'),
    );

    when(mockDio.options).thenReturn(BaseOptions());
    when(mockDio.fetch(any)).thenAnswer((_) async => response);

    final querry = <String,dynamic>{};

    final articles = await apiClient.getArticles(querry);

    expect(articles, isA<ArticleResponseDTO>());
    expect(articles.articles.first.title, 'Flutter News!');
    verify(mockDio.fetch(any)).called(1);
  });
}