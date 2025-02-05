import 'package:get/get.dart';
import 'package:storymate/models/book.dart';
import 'package:storymate/views/read/book_intro_page.dart';

class HomeController extends GetxController {
  // 동화 카테고리 책 리스트
  var fairyTales = <Book>[].obs;

  // 단/중편 소설 카테고리 책 리스트
  var shortNovels = <Book>[].obs;

  // 장편소설 카테고리 책 리스트
  var longNovels = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBooks();
  }

  void loadBooks() {
    fairyTales.assignAll([
      Book(
          title: "시골 쥐 서울 구경",
          tags: ["동화", "교훈", "이솝우화"],
          coverImage: "assets/books/fairy_1.png"),
      Book(
          title: "미운 아기 오리",
          tags: ["동화", "교훈", "안데르센"],
          coverImage: "assets/books/fairy_2.png"),
      Book(
          title: "흥부와 놀부",
          tags: ["형제애", "교훈", "욕심"],
          coverImage: "assets/books/fairy_3.png"),
      Book(
          title: "성냥팔이 소녀",
          tags: ["안데르센", "동화", "슬픔"],
          coverImage: "assets/books/fairy_4.png"),
      Book(
          title: "엄지공주",
          tags: ["안데르센", "동화", "모험"],
          coverImage: "assets/books/fairy_5.png"),
      Book(
          title: "인어공주",
          tags: ["안데르센", "모험", "사랑"],
          coverImage: "assets/books/fairy_6.png"),
    ]);

    shortNovels.assignAll([
      Book(
          title: "운수 좋은 날",
          tags: ["일제강점기", "아이러니", "전통"],
          coverImage: "assets/books/short_1.png"),
      Book(
          title: "심봉사",
          tags: ["고전소설", "동화", "효"],
          coverImage: "assets/books/short_2.png"),
      Book(
          title: "동백꽃",
          tags: ["봄감자", "사랑", "고전문학"],
          coverImage: "assets/books/short_3.png"),
      Book(
          title: "메밀꽃 필 무렵",
          tags: ["향토문학", "사랑", "노스탤지어"],
          coverImage: "assets/books/short_4.png"),
    ]);

    longNovels.assignAll([
      Book(
          title: "홍길동전",
          tags: ["조선히어로", "신분극복", "모험"],
          coverImage: "assets/books/long_1.png"),
    ]);
  }

  // 선택된 카테고리 정보
  final RxString selectedCategory = ''.obs;

  // 카테고리 선택 메서드
  void setCategory(String category) {
    selectedCategory.value = category;
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
