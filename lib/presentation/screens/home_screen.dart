import 'package:flutter/material.dart';
import 'package:my_news_app/controller/article_controller.dart';
import 'package:my_news_app/presentation/molecules/bottom_nav_bar.dart';
import 'package:my_news_app/repository/article_repository.dart';

import '../../model/article_model.dart';
import '../molecules/image_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Dependency Injection
  final _articleController = ArticleController(ArticleRepository());

  //Define Variables
  List<Article> _articles = [];

  //Get Details
  Future<List<Article>> getDetails() async {
    var response = await _articleController.getArticles();
    _articles = response;
    print(_articles[0].publishAt);
    return response;
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          //News of the Day Section Start
          FutureBuilder(
            builder: (BuildContext context, snapshot) => snapshot
                        .connectionState ==
                    ConnectionState.waiting
                ? const SizedBox(child: LinearProgressIndicator())
                : snapshot.hasData
                    ? Column(
                        children: [
                          ImageContainer(
                            article: (snapshot.data as List<Article>)[0],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Latest News',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text('More',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              (snapshot.data as List<
                                                                          Article>)[
                                                                      index]
                                                                  .urlToImage
                                                                  .toString()),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Text(
                                                    (snapshot.data as List<
                                                            Article>)[index]
                                                        .title
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(height: 1.5),
                                                  ),
                                                  Text(
                                                      "${DateTime.now().difference(DateTime.parse((snapshot.data as List<Article>)[index].publishAt.toString())).inMinutes} Minutes ago"),
                                                  TextButton(
                                                      onPressed: () {},
                                                      style:
                                                          TextButton.styleFrom(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero),
                                                      child: Row(
                                                        children: [
                                                          Text("Learn More",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black)),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          const Icon(Icons
                                                              .arrow_circle_right),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ));
                                      }),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : const Center(),
            future: getDetails(),
          ),

          //News of the Day End
        ],
      ),
    );
  }
}
