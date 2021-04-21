import 'package:boletin/model/article.dart';
import 'package:boletin/model/article_preview.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

const _BASE_URL = "https://www.boletin.buap.mx/";

class NetworkDataSource {
  Future<List<ArticlePreview>> getAllArticles() async {
    final response = await http.get(_buildUrl("?q=boletines"));
    final document = parse(response.body);
    return document.querySelectorAll("div .views-row").map((element) {
      final titleElement = element.querySelector("h4 a");
      final dateElement = element.querySelector(".date-display-single");
      final summaryElement = element.querySelector(
        "div.field-content.col-xs-8",
      );
      return ArticlePreview(
        titleElement.attributes["href"],
        titleElement.innerHtml,
        summaryElement.innerHtml.replaceAll(dateElement.outerHtml, "").trim(),
        dateElement.innerHtml,
        element.querySelectorAll("div.field-content a")[1].innerHtml ??
            "Universidad",
        element.querySelector("a img").attributes["src"],
      );
    }).toList();
  }

  Future<Article> getFullArticle(String url) async {
    final response = await http.get(_buildUrl(url));
    final document = parse(response.body);
    final bodyText = document
        .querySelectorAll("div.field-item p")
        .map((e) {
          return e.text.trimLeft().trimRight();
        })
        .where((e) => e.length > 0)
        .join("\n");
    final imagesUrls = document.querySelectorAll("img.img-responsive").map((e) {
      return e.attributes["src"].replaceAll(
        "styles/thumbnails_noticias/public/",
        "",
      );
    }).toList();
    if (imagesUrls.length > 1) {
      // Removes the duplicated image when there's a carousel.
      imagesUrls.removeAt(0);
    }
    return Article(
      url,
      document.querySelector(".page-header").innerHtml,
      bodyText,
      document.querySelector("span.date-display-single").innerHtml,
      document.querySelector('a[typeof="skos:Concept"]').innerHtml ??
          "Universidad",
      imagesUrls,
    );
  }

  Uri _buildUrl(String endpoint) {
    return Uri.parse("$_BASE_URL$endpoint");
  }
}
