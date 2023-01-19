import 'news.dart';

/// Provides access to and operations on all defined News items.
class NewsCollection {
  NewsCollection(news) : _newss = news;

  final List<News> _newss;

  List<String> getNewsIDs() {
    return _newss.map((data) => data.id).toList();
  }

  News getNews(newsID) {
    return _newss.firstWhere((data) => data.id == newsID);
  }

  List<String> getAssociatedNewsIDs(String userID) {
    return getNewsIDs()
        .where((newsID) => getNews(newsID).userID == userID)
        .toList();
  }
}
