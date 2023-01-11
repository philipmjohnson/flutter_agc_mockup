/// Defines the domain model path strings for [FirestoreService].
class FirestorePath {
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  static String jobs(String uid) => 'users/$uid/jobs';
  static String entry(String uid, String entryId) =>
      'users/$uid/entries/$entryId';
  static String entries(String uid) => 'users/$uid/entries';

  static String chapter(String uid, String chapterId) =>
      'users/$uid/chapters/$chapterId';
  static String chapters(String uid) => 'users/$uid/chapters';

  static String discussion(String uid, String discussionId) =>
      'users/$uid/discussions/$discussionId';
  static String discussions(String uid) => 'users/$uid/discussions';

  static String garden(String uid, String gardenId) =>
      'users/$uid/gardens/$gardenId';
  static String gardens(String uid) => 'users/$uid/gardens';

  static String newsItem(String uid, String newsId) =>
      'users/$uid/news/$newsId';
  static String news(String uid) => 'users/$uid/news';

  static String outcome(String uid, String outcomeId) =>
      'users/$uid/outcomes/$outcomeId';
  static String outcomes(String uid) => 'users/$uid/outcomes';

  static String seed(String uid, String seedId) => 'users/$uid/seeds/$seedId';
  static String seeds(String uid) => 'users/$uid/seeds';
}
