import 'dart:typed_data';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:newsapp/data/models/articleResponseDTO.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:typed_data';

part 'articleApi.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2')
abstract class ArticleHttpClient
{
  factory ArticleHttpClient(Dio dio, {String baseUrl}) = _ArticleHttpClient;

   @GET('/everything')
   Future<ArticleResponseDTO> getArticles(@Queries() Map<String, dynamic> queries);

}