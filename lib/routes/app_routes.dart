// 라우팅 관리

import 'package:get/get.dart';
import 'package:storymate/views/add_memo_page.dart';
import 'package:storymate/views/book_intro_page.dart';
import 'package:storymate/views/book_list_page.dart';
import 'package:storymate/views/book_read_page.dart';
import 'package:storymate/views/book_search_page.dart';
import 'package:storymate/views/home_page.dart';
import 'package:storymate/views/character_selection_screen.dart';
import 'package:storymate/views/chat_screen.dart';

class AppRoutes {
  static const HOME = '/';
  static const CHARACTER_SELECTION = '/character_selection';
  static const CHAT = '/chat';

  static final routes = [
    GetPage(
      name: HOME,
      page: () => HomePage(),
    ),
    // 작품 목록 화면
    GetPage(
      name: '/book_list',
      page: () => BookListPage(),
    ),
    // 작품 검색 화면
    GetPage(
      name: '/book_search',
      page: () => BookSearchPage(),
    ),
    // 작품 소개 화면
    GetPage(
      name: '/book_intro',
      page: () => BookIntroPage(),
      children: [
        // 작품 읽기 화면
        GetPage(
          name: '/read',
          page: () => BookReadPage(),
        ),
      ],
    ),
    // 메모 작성창
    GetPage(
      name: '/memo',
      page: () => AddMemoPage(),
    ), // 캐릭터 선택 화면
    GetPage(
      name: CHARACTER_SELECTION,
      page: () => CharacterSelectionScreen(),
    ),
    // 채팅 화면
    GetPage(
      name: CHAT,
      page: () => ChatScreen(),
    ),
  ];
}
