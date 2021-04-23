import 'package:boletin/main.dart';
import 'package:boletin/model/article_preview.dart';
import 'package:boletin/widgets/article_preview_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'article_preview_item.dart';

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
            return LayoutBuilder(
              builder: (context, constraints) {
                print(constraints.maxWidth);
                if (constraints.maxWidth < 600) {
                  return ListView.builder(
                    itemCount: previews.length,
                    itemBuilder: (context, index) => ArticlePreviewItem(
                      previews[index],
                    ),
                  );
                } else {
                  return StaggeredGridView.countBuilder(
                    itemCount: previews.length,
                    crossAxisCount: 4,
                    itemBuilder: (context, index) =>
                        ArticlePreviewItem(previews[index]),
                    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                  );
                }
              },
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
