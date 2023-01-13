/// Defines the domain model path strings for [FirestoreService].
class FirestorePath {
  static String chapter(String chapterID) => 'chapters/$chapterID';
  static String chapters() => 'chapters';

  static String garden(String gardenID) => 'gardens/$gardenID';
  static String gardens() => 'gardens';

  static String newsItem(String newsID) => 'news/$newsID';
  static String news() => 'news';

  static String user(String userID) => 'users/$userID';
  static String users() => 'users';
}
