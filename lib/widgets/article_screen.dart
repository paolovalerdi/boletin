import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../main.dart';
import '../model/article.dart';

class ArticleScreen extends StatelessWidget {
  final String url;

  const ArticleScreen({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FutureBuilder(
          future: networkDataSource.getFullArticle(url),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final textTheme = Theme.of(context).textTheme;
              final Article article = snapshot.data;
              return Center(
                child: SizedBox(
                  width: 800,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 64, bottom: 64),
                      child: Column(
                        children: [
                          Text(
                            article.title,
                            textAlign: TextAlign.center,
                            style: textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "${article.date} • ${article.category}",
                            style: textTheme.caption,
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: 600,
                            height: 400,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    child: PageView.builder(
                                      controller: pageController,
                                      itemCount: article.images.length,
                                      itemBuilder: (context, index) {
                                        return CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: article.images[index],
                                        );
                                      },
                                    ),
                                    foregroundDecoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withAlpha(100),
                                          Colors.transparent
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: SmoothPageIndicator(
                                    controller: pageController,
                                    count: article.images.length,
                                    effect: WormEffect(
                                      dotHeight: 8,
                                      radius: 8,
                                      dotWidth: 8,
                                      activeDotColor: Colors.white,
                                    ),
                                  ),
                                  bottom: 16,
                                  right: 16,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            article.body,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyText1.copyWith(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
