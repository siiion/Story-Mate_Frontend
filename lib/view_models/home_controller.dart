import 'package:get/get.dart';
import 'package:storymate/models/book.dart';
import 'package:storymate/views/read/book_intro_page.dart';

class HomeController extends GetxController {
  // 전체 책 목록
  var books = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBooks();
  }

  void loadBooks() {
    books.assignAll([
      Book(
        title: "시골 쥐 서울 구경",
        tags: ["동화", "교훈", "이솝우화"],
        coverImage: "assets/books/fairy_1.png",
        category: "동화",
      ),
      Book(
        title: "미운 아기 오리",
        tags: ["동화", "교훈", "안데르센"],
        coverImage: "assets/books/fairy_2.png",
        category: "동화",
      ),
      Book(
        title: "흥부와 놀부",
        tags: ["형제애", "교훈", "욕심"],
        coverImage: "assets/books/fairy_3.png",
        category: "동화",
      ),
      Book(
        title: "성냥팔이 소녀",
        tags: ["안데르센", "동화", "슬픔"],
        coverImage: "assets/books/fairy_4.png",
        category: "동화",
      ),
      Book(
        title: "엄지공주",
        tags: ["안데르센", "동화", "모험"],
        coverImage: "assets/books/fairy_5.png",
        category: "동화",
      ),
      Book(
        title: "인어공주",
        tags: ["안데르센", "모험", "사랑"],
        coverImage: "assets/books/fairy_6.png",
        category: "동화",
      ),
      Book(
        title: "운수 좋은 날",
        tags: ["일제강점기", "아이러니", "전통"],
        coverImage: "assets/books/short_1.png",
        category: "단/중편 소설",
      ),
      Book(
        title: "심봉사",
        tags: ["고전소설", "동화", "효"],
        coverImage: "assets/books/short_2.png",
        category: "단/중편 소설",
      ),
      Book(
        title: "동백꽃",
        tags: ["봄감자", "사랑", "고전문학"],
        coverImage: "assets/books/short_3.png",
        category: "단/중편 소설",
      ),
      Book(
        title: "메밀꽃 필 무렵",
        tags: ["향토문학", "사랑", "노스탤지어"],
        coverImage: "assets/books/short_4.png",
        category: "단/중편 소설",
      ),
      Book(
        title: "홍길동전",
        tags: ["조선히어로", "신분극복", "모험"],
        coverImage: "assets/books/long_1.png",
        category: "장편 소설",
      ),
    ]);
  }

  // 카테고리별 책 목록 반환
  List<Book> getBooksByCategory(String category) {
    return books.where((book) => book.category == category).toList();
  }

  // 카테고리 선택 메서드
  void setCategory(String category) {
    Get.toNamed('/book_list', arguments: category);
  }

  // 작품 소개 화면으로 이동
  void toIntroPage(String title) {
    Get.to(
      BookIntroPage(),
      arguments: {
        'title': title,
      },
    );
  }
}
