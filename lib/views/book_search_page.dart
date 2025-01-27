import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/components/custom_card.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/book_search_controller.dart';

class BookSearchPage extends StatelessWidget {
  const BookSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BookSearchController controller = Get.put(BookSearchController());

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 66),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 뒤로 가기 버튼
                  GestureDetector(
                    onTap: () {
                      controller.goBack();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xff090A0A),
                    ),
                  ),
                  Container(
                    width: 320,
                    height: 56,
                    decoration: ShapeDecoration(
                      color: Color(0xFF9B9ECF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        // 검색 카테고리 드롭다운
                        Container(
                          width: 100,
                          height: 58,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 2, color: Color(0xFF9B9ECF)),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                          ),
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: Obx(() {
                                return DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(20),
                                  isExpanded: false,
                                  value: controller.selectedCategory.value,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  dropdownColor: Colors.white,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Jua',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  items:
                                      controller.categories.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller.changeCategory(newValue);
                                    }
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 작품 검색창
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.w400,
                            ),
                            controller: controller.searchController,
                            decoration: InputDecoration(
                              hintText: '검색어를 입력하세요',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                            ),
                            onChanged: (query) {
                              controller.searchBooks(query); // 검색 호출
                            },
                          ),
                        ),
                        // 검색 버튼
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              controller.searchBooks(
                                  controller.searchController.text);
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 키워드 예시
            Obx(
              () => controller.keywords.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: controller.keywords.map((keyword) {
                            return GestureDetector(
                              onTap: () {
                                controller.searchController.text = keyword;
                                controller.searchBooks(keyword);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: AppTheme.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  keyword,
                                  style: TextStyle(
                                    color: Color(0xFF7C7C7C),
                                    fontSize: 18,
                                    fontFamily: 'Jua',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
            const SizedBox(height: 20),
            // 검색 결과
            Obx(
              () => controller.searchResults.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10), // 그리드 아이템 여백 설정
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600
                                  ? 3
                                  : 2, // 열 개수 (반응형)
                          crossAxisSpacing: 30, // 열 간격
                          mainAxisSpacing: 30, // 행 간격
                          childAspectRatio: 3 / 4, // 아이템 비율 (가로/세로)
                        ),
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          final result = controller.searchResults[index];
                          return CustomCard(
                            title: result['title']!,
                            tags: result['tags']!,
                            onTap: () {
                              controller.toIntroPage(result['title']!);
                            },
                          );
                        },
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
