import 'package:flutter/cupertino.dart';
import 'package:my_news_app/controller/article_controller.dart';
import 'package:my_news_app/repository/article_repository.dart';

import '../model/article_model.dart';

enum HomeState { Initial, Loading, Loaded, Error }

class ArticleModel extends ChangeNotifier {
  //Dependency Injection
  var _articleController = ArticleController(ArticleRepository());
  //State Define
  HomeState _homeState = HomeState.Initial;

  List<Article> _articles = [];

  HomeState get homeState => _homeState;
  List<Article> get articles => _articles;
  ArticleModel();
  void setArticles(query) async {
    _homeState = HomeState.Loading;
    try {
      _homeState = HomeState.Loaded;
      final articles = await _articleController.getArticlesByCategory(query);
      _articles = articles;
    } catch (e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  void searchArticles(keyword) async {
    _homeState = HomeState.Loading;
    try {
      _homeState = HomeState.Loaded;
      final results = _articles
          .where((element) => element.content!
              .toLowerCase()
              .contains(keyword.toString().toLowerCase()))
          .toList();
      _articles = results;
    } catch (e) {
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }
}
