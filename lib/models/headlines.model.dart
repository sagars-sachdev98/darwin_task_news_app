class Source {
  String id;
  String name;
  Source();
  Source.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      name = jsonMap['name'];
    } catch (e) {}
  }
}

class Headlines {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  bool isLoading = false;
  Source source;
  Headlines();
  Headlines.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      source = Source.fromJSON(jsonMap['source']);
      author = jsonMap['author'];
      title = jsonMap['title'];
      description = jsonMap['description'];
      url = jsonMap['url'].toString();
      urlToImage = jsonMap['urlToImage'].toString();
      publishedAt = jsonMap['publishedAt'];
      content = jsonMap['content'];
    } catch (e) {}
  }
}
