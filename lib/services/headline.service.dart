import 'package:darwin_task/models/headlines.model.dart';
import 'package:dio/dio.dart';

class HeadlineService {
  Future<List<Headlines>> getTopHeadlines() async {
    Dio dio = new Dio();
    Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=20a00a86cdd547cdb0a559324b790429');

    List list =
        response.data['articles'] == null ? [] : response.data['articles'];

    List<Headlines> headlines = [];
    list.forEach((headline) {
      headlines.add(Headlines.fromJSON(headline));
    });

    return headlines;
  }

  Future<List<Headlines>> getEveryThing(String search) async {
    Dio dio = new Dio();
    Response response = await dio.get(
        'https://newsapi.org/v2/everything?q=`$search`&apiKey=20a00a86cdd547cdb0a559324b790429');

    List list =
        response.data['articles'] == null ? [] : response.data['articles'];

    List<Headlines> headlines = [];
    list.forEach((headline) {
      headlines.add(Headlines.fromJSON(headline));
    });

    return headlines;
  }
}
