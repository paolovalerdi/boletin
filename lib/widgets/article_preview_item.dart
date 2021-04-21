import 'package:boletin/model/article_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArticlePreviewItem extends StatelessWidget {
  final ArticlePreview _preview;

  const ArticlePreviewItem(this._preview, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return SizedBox(
      width: 100,
      height: 100,
      child: CachedNetworkImage(
        imageUrl: _preview.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: Column(
        children: [
          Text(_preview.title),
          Text(_preview.summary),
          Text(_preview.category),
          Text(_preview.date),
        ],
      ),
    );
  }
}
