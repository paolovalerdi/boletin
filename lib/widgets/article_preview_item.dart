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
            SizedBox(width: 16),
            _buildContent(Theme.of(context).textTheme),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return SizedBox(
      width: 120,
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: _preview.thumbnailUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContent(TextTheme textTheme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_preview.title, style: textTheme.headline6),
          SizedBox(height: 8),
          Text(
            _preview.summary,
            style: textTheme.bodyText1,
          ),
          SizedBox(height: 24),
          Text(
            "${_preview.date} • ${_preview.category}",
            style: textTheme.caption,
          ),
        ],
      ),
    );
  }
}
