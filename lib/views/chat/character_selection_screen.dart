import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../components/custom_bottom_bar.dart';
import '../../../routes/app_routes.dart';

class CharacterSelectionScreen extends StatefulWidget {
  const CharacterSelectionScreen({super.key});

  @override
  State<CharacterSelectionScreen> createState() =>
      _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  final List<Map<String, String>> characters = [
    {"name": "팅커벨", "work": "피터팬"},
    {"name": "신데렐라", "work": "신데렐라"},
    {"name": "알라딘", "work": "알라딘"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Text(
                '작품 속 인물과 이야기를 나눠보세요!',
                style: TextStyle(
                  fontFamily: 'Jua',
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/message.svg', // 메시지 아이콘
                  width: 16,
                  height: 16,
                  color: Color(0xFF9B9FD0),
                ),
                SizedBox(width: 4),
                Text(
                  '00개', // 메시지 갯수
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Jua',
                    color: Color(0xFF9B9FD0),
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "인물/작품으로 검색",
                hintStyle: TextStyle(
                  fontFamily: 'Jua',
                  color: Color(0xFF9B9FD0),
                ),
                suffixIcon: Icon(Icons.search, color: Color(0xFF9B9FD0)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.purple),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return GestureDetector(
                  onTap: () {
                    // 선택한 캐릭터로 이동
                    Get.toNamed(
                      AppRoutes.CHAT,
                      arguments: character["name"],
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey.shade200,
                          child: Text(
                            character["name"]![0],
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        character["name"]!,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        character["work"]!,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Jua',
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF9B9FD0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '00',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Jua',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 1, // 대화하기 탭
      ),
    );
  }
}
