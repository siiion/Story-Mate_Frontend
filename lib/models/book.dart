class Book {
  final String title;
  final List<String> tags;
  final String coverImage;
  final String category; // 카테고리
  final String author; // 작가명
  final String publishedYear; // 출판년도
  final String description; // 작품 소개글

  Book({
    required this.title,
    required this.tags,
    required this.coverImage,
    required this.category,
    this.author = "미상", // 기본값 "미상"
    this.publishedYear = "미상", // 기본값 "미상"
    this.description = "작품 소개글이 없습니다.", // 기본값 "작품 소개글이 없습니다."
  });
}
