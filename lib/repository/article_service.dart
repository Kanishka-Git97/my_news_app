import '../model/article_model.dart';

abstract class ArticleService {
  Future<List<Article>> getArticles();
}
