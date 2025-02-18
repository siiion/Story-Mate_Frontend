class Book {
  final String title;
  final List<String> tags;
  final String coverImage;
  final String category;
  final String author;
  final String publishedYear;
  final String description;

  Book({
    required this.title,
    this.tags = const ["태그 없음"], // 기본값 추가
    this.coverImage = "assets/books/broken_image.png", // 기본 이미지 추가
    required this.category,
    this.author = "미상",
    this.publishedYear = "미상",
    this.description = "작품 소개글이 없습니다.",
  });

  // JSON을 Book 객체로 변환하는 factory 생성자
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? "제목 없음",
      tags: json['tags'] != null ? List<String>.from(json['tags']) : ["태그 없음"],
      coverImage: json['coverImage'] ?? "assets/books/broken_image.png",
      category: json['category'] ?? "미상",
      author: json['author'] ?? "미상",
      publishedYear: json['publishedYear'] ?? "미상",
      description: json['description'] ?? "작품 소개글이 없습니다.",
    );
  }

  // Book 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'tags': tags,
      'coverImage': coverImage,
      'category': category,
      'author': author,
      'publishedYear': publishedYear,
      'description': description,
    };
  }
}
