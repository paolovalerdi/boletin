class Article {
  final String url;
  final String title;
  final String body;
  final String date;
  final String category;
  final List<String> images;

  Article(
    this.url,
    this.title,
    this.body,
    this.date,
    this.category,
    this.images,
  );

  @override
  String toString() {
    return "{\n\turl: $url,\n\ttitle: $title,\n\tbody: $body,\n\tdate: $date,\n\tcategory: $category,\n\timages: $images}";
  }
}
