import 'package:boletin/main.dart';
import 'package:boletin/model/article_preview.dart';
import 'package:boletin/widgets/article_preview_item.dart';
import 'package:flutter/material.dart';

class PreviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boletin"),
      ),
      body: FutureBuilder(
        future: networkDataSource.getAllArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<ArticlePreview> previews = snapshot.data;
            return ListView.builder(
              itemCount: previews.length,
              itemBuilder: (context, index) => ArticlePreviewItem(
                previews[index],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
