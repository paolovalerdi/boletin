class ArticlePreview {
  final String url;
  final String title;
  final String summary;
  final String date;
  final String category;
  final String thumbnailUrl;

  ArticlePreview(
    this.url,
    this.title,
    this.summary,
    this.date,
    this.category,
    this.thumbnailUrl,
  );

  @override
  String toString() {
    return "{ url: $url, title: $title, summary: $summary, date: $date, category: $category, thumbnailUrl: $thumbnailUrl}";
  }
}
