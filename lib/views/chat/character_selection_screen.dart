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
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> characters = [
    {"name": "김첨지", "book": "운수 좋은 날", "image": "assets/kim_cheomji.png"},
    {"name": "인어공주", "book": "인어공주", "image": "mermaid.png"},
    {"name": "성냥팔이 소녀", "book": "성냥팔이 소녀"},
    {"name": "심봉사", "book": "심봉사"},
    {"name": "엄지공주", "book": "엄지공주"},
    {"name": "동백꽃", "book": "동백꽃"},
    {"name": "시골쥐", "book": "시골쥐 서울구경"},
    {"name": "미운 아기 오리", "book": "미운 아기 오리"},
    {"name": "허생원", "book": "메밀꽃 필 무렵"},
    {"name": "홍길동", "book": "홍길동전"},
  ];

  List<Map<String, String>> filteredCharacters = [];

  @override
  void initState() {
    super.initState();
    filteredCharacters = characters; // 초기값 설정
  }

  void filterCharacters(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCharacters = characters;
      } else {
        filteredCharacters = characters
            .where((character) =>
                character["name"]!.contains(query) ||
                character["book"]!.contains(query))
            .toList();
      }
    });
  }

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
              controller: searchController,
              onChanged: (query) => filterCharacters(query),
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
              itemCount: filteredCharacters.length,
              itemBuilder: (context, index) {
                final character = filteredCharacters[index];
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
                          backgroundImage: character["image"] != null
                              ? AssetImage(character["image"]!)
                              : null,
                          child: character["image"] == null
                              ? Text(
                                  character["name"]![0],
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontFamily: 'Jua',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
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
                        character["book"]!,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Jua',
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
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
