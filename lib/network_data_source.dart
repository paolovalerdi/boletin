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

  Uri _buildUrl(String endpoint) {
    return Uri.parse("$_BASE_URL$endpoint");
  }
}
