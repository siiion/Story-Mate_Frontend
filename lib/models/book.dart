class Book {
  final String title;
  final List<String> tags;
  final String coverImage;
  final String category; // 카테고리 추가

  Book({
    required this.title,
    required this.tags,
    required this.coverImage,
    required this.category,
  });
}
