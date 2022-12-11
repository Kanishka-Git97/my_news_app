import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_news_app/repository/article_service.dart';
import 'package:my_news_app/services/api_service.dart';

import '../model/article_model.dart';

class ArticleRepository implements ArticleService {
  //API Injection
  final ApiService _service = ApiService();
  @override
  Future<List<Article>> getArticles() async {
    Response res = await get(Uri.parse(_service.getAll));
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json["articles"];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
     throw("Can't get the Articles");
    }
  }
}