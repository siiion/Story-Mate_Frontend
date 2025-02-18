import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storymate/models/book.dart';
import 'package:storymate/views/read/book_intro_page.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  String userName = '사용자';

  // 전체 책 목록
  var books = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBooks();
    userName = box.read("userName") ?? "사용자";
  }

  void loadBooks() {
    books.assignAll([
      Book(
        title: "시골 쥐 서울 구경",
        tags: ["동화", "교훈", "이솝우화"],
        coverImage: "assets/books/fairy_1.png",
        category: "동화",
        author: "방정환",
        publishedYear: "1926",
        description: "시골 쥐와 서울 쥐의 삶을 비교하는 유명한 우화입니다.",
      ),
      Book(
        title: "미운 아기 오리",
        tags: ["동화", "교훈", "안데르센"],
        coverImage: "assets/books/fairy_2.png",
        category: "동화",
        author: "안데르센",
        publishedYear: "1843",
        description: "자신의 정체성을 찾는 아기 오리의 성장 이야기입니다.",
      ),
      Book(
        title: "흥부와 놀부",
        tags: ["형제애", "교훈", "욕심"],
        coverImage: "assets/books/fairy_3.png",
        category: "동화",
        description: "착한 흥부와 욕심 많은 놀부의 이야기를 담은 전래동화입니다.",
      ),
      Book(
        title: "성냥팔이 소녀",
        tags: ["안데르센", "동화", "슬픔"],
        coverImage: "assets/books/fairy_4.png",
        category: "동화",
        author: "안데르센",
        publishedYear: "1845",
        description: "추운 겨울밤, 성냥을 팔며 희망을 꿈꾸는 소녀의 이야기입니다.",
      ),
      Book(
        title: "엄지공주",
        tags: ["안데르센", "동화", "모험"],
        coverImage: "assets/books/fairy_5.png",
        category: "동화",
        author: "안데르센",
        publishedYear: "1835",
        description: "엄지손가락 크기로 태어난 소녀가 여러 모험을 겪으며 행복을 찾아가는 이야기입니다.",
      ),
      Book(
        title: "인어공주",
        tags: ["안데르센", "모험", "사랑"],
        coverImage: "assets/books/fairy_6.png",
        category: "동화",
        author: "안데르센",
        publishedYear: "1837",
        description: "바다 속 왕국의 인어공주가 사랑을 위해 자신의 목소리를 희생하는 슬픈 동화입니다.",
      ),
      Book(
        title: "운수 좋은 날",
        tags: ["일제강점기", "아이러니", "전통"],
        coverImage: "assets/books/short_1.png",
        category: "단/중편 소설",
        author: "현진건",
        publishedYear: "1924",
        description: "가난한 인력거꾼이 운이 좋은 날이라고 믿지만, 결국 비극적인 결말을 맞이하는 작품입니다.",
      ),
      Book(
        title: "심봉사",
        tags: ["고전소설", "동화", "효"],
        coverImage: "assets/books/short_2.png",
        category: "단/중편 소설",
        description: "맹인 심봉사가 기적적으로 눈을 뜨게 되는 이야기로, 효(孝)에 대한 교훈을 담고 있습니다.",
      ),
      Book(
        title: "동백꽃",
        tags: ["봄감자", "사랑", "고전문학"],
        coverImage: "assets/books/short_3.png",
        category: "단/중편 소설",
        author: "김유정",
        publishedYear: "1936",
        description: "촌스러운 소년과 소녀 사이의 풋풋한 감정을 담은 한국 문학의 대표적인 단편소설입니다.",
      ),
      Book(
        title: "메밀꽃 필 무렵",
        tags: ["향토문학", "사랑", "노스탤지어"],
        coverImage: "assets/books/short_4.png",
        category: "단/중편 소설",
        author: "이효석",
        publishedYear: "1936",
        description: "메밀꽃이 흐드러지게 핀 밤, 장돌뱅이 허생원이 자신의 과거와 사랑을 회상하는 이야기입니다.",
      ),
      Book(
        title: "홍길동전",
        tags: ["조선히어로", "신분극복", "모험"],
        coverImage: "assets/books/long_1.png",
        category: "장편 소설",
        author: "허균",
        publishedYear: "17세기",
        description:
            "조선 시대 신분 차별을 극복하고 정의를 실현하는 영웅 홍길동의 이야기를 그린 한국 최초의 한글 소설입니다.",
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
