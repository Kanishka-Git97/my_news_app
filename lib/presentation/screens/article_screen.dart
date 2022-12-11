import 'package:flutter/material.dart';

import '../../model/article_model.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({Key? key}) : super(key: key);
  static const routeName = '/article';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Test"),
      ),
    );
  }
}
