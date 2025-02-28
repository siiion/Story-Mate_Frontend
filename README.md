# 🌟 StoryMate(스토리메이트)

![Group 123 (1)](https://github.com/user-attachments/assets/95277c52-590e-4e08-9e0f-7f7a279a6a3d)

## 📌 프로젝트 소개

- **프로젝트 개요**:  
  현대인들은 고전 문학을 접할 기회가 점점 줄어들고 있으며, 이를 흥미롭고 새로운 방식으로 경험할 방법이 부족합니다.  
  본 프로젝트는 저작권이 만료된 문학작품(동화, 단·중편 소설, 장편 소설)을 활용하여 사용자가 모바일 애플리케이션에서 작품을 읽고, 해당 작품 속 **핵심 인물과 대화할 수 있는 AI 챗봇 기능**을 제공합니다.  
  이를 통해 사용자는 **기존 문학을 새로운 방식으로 탐색하고, 더욱 몰입할 수 있는 독서 경험**을 즐길 수 있습니다.

- **주요 기능**:
  - 🗣️ **AI 캐릭터 대화 기능**:  
    작품 내용을 학습한 AI 챗봇과 대화를 나누며, 작품 속 인물과 직접 소통하는 듯한 경험을 제공합니다.
  - ❓ **문학 퀴즈**:  
    읽은 작품과 관련된 퀴즈를 풀어보며, 내용을 복습하고 이해도를 높일 수 있습니다.
  - 📖 **작품 읽기 기능**:  
    문학작품을 앱 내에서 편리하게 읽을 수 있으며, **하이라이트, 책갈피, 메모 기능**을 지원합니다.
  - 📚 **마이페이지**:  
    사용자가 감상 중인 작품과 감상 완료한 작품 목록을 관리할 수 있습니다.

---

## 🚀 기술 스택
| 구분 | 기술 |
|------|------|
| **Frontend** | Flutter |
| **State Management** | GetX |
| **Networking & API** | Dio, http, web_socket_channel |
| **Storage** | SharedPreferences, GetStorage |
| **UI & Styling** | Flutter SVG, Flutter ScreenUtil |
| **Date & Localization** | intl |
| **Authentication** | Kakao Flutter SDK |
| **In-App Purchases** | in_app_purchase |
| **Web & Deep Linking** | WebView Flutter, URL Launcher |
| **Utilities** | Flutter Dotenv, Package Info Plus |
| **Testing & Linting** | Flutter Test, Flutter Lints |
| **App Icons** | Flutter Launcher Icons |

---

## 📂 폴더 구조
```bash
├── README.md                  # 프로젝트 설명 문서
├── pubspec.yaml               # Flutter 프로젝트 설정 및 의존성 관리
├── 📂 lib/                     # Flutter 주요 코드
│   ├── main.dart               # 앱 실행 시작점
│   ├── components/             # 재사용 가능한 UI 컴포넌트
│   ├── controllers/            # 상태 및 비즈니스 로직
│   ├── models/                 # 데이터 모델
│   ├── routes/                 # 라우팅 관리
│   ├── services/               # API 및 데이터 관리
│   ├── utils/                  # 유틸리티 함수
│   ├── view_models/            # MVVM 패턴 ViewModel
│   └── views/                  # 화면 관련 코드
├── 📂 assets/                  # 정적 리소스 (이미지, 아이콘, 폰트, 데이터 파일)
```
---

## 🔗 API 연동

### 📍 기본 API 주소
- API_URL=https://be.dev.storymate.site

### ✅ API 연동 특징
- HTTP 통신 (http 패키지 활용)
- JWT 기반 사용자 인증 & SharedPreferences 토큰 관리
- 책 읽기, AI 챗봇, 퀴즈, 결제 기능 포함

---

## 🛠️ 주요 기능

### 📖 작품 읽기 기능  
| 항목 | 내용 |
|------|------|
| **기능** | 문학작품을 앱 내에서 읽을 수 있으며, **하이라이트, 책갈피, 메모 기능**을 제공합니다. |
| **스크린샷** | <img src="https://github.com/user-attachments/assets/350ae68d-c61c-428c-b06e-34c071827ec8" width="200px"> |

### 🗣️ AI 캐릭터와 대화  
| 항목 | 내용 |
|------|------|
| **기능** | 작품 속 **핵심 인물과 AI 챗봇을 통해 대화**할 수 있습니다. 캐릭터의 성격과 작품 내용을 기반으로 몰입감 있는 대화를 지원합니다. |
| **스크린샷** | <img src="https://github.com/user-attachments/assets/dead4006-f2ee-42fa-9d81-6a0fae73c925" width="200px"> |

### ❓ 문학 퀴즈  
| 항목 | 내용 |
|------|------|
| **기능** | 작품과 관련된 **퀴즈를 풀며 작품 내용을 복습**할 수 있습니다. AI 캐릭터가 직접 문제를 출제합니다. |
| **스크린샷** | <img src="https://github.com/user-attachments/assets/7310dee9-ede5-437f-85b5-226d8f52f392" width="200px"> |

### 🔐 JWT 기반 사용자 인증  
| 항목 | 내용 |
|------|------|
| **기능** | **카카오 소셜 로그인**을 통해 간편하게 회원가입 및 로그인할 수 있으며, `SharedPreferences`를 이용한 **토큰 기반 인증 시스템**을 적용하였습니다. |
| **스크린샷** | <img src="https://github.com/user-attachments/assets/79098dca-6330-4a82-9bc2-bd606d8247e5" width="200px"> |

### 💳 카카오페이 결제 시스템  
| 항목 | 내용 |
|------|------|
| **기능** | 앱 내 결제를 통해 **추가 콘텐츠를 이용**할 수 있으며, **카카오페이 API 연동**을 통해 안전한 결제 경험을 제공합니다. |
| **스크린샷** | <p align="left"> <img src="https://github.com/user-attachments/assets/b0c1ace6-da5a-42ac-9be9-9d8f3f1fc03b" width="150px"> <img src="https://github.com/user-attachments/assets/62906caa-77eb-4fa4-a469-7d30a7b2a0d4" width="150px"> <img src="https://github.com/user-attachments/assets/602924ff-8a65-4e5c-8856-a844a23ca33f" width="150px"> <img src="https://github.com/user-attachments/assets/92ccf760-aca6-4080-bae7-5cc618211a67" width="150px"> </p> |

---

## 📢 팀원 소개

| 이름 | 역할 | 담당 기능 | GitHub |
|------|------|----------------------|--------|
| 전시원 | 프론트엔드 개발 | 작품 읽기 기능, 문학 퀴즈, 카카오페이 결제 시스템 | [@siiion](https://github.com/siiion) |
| 장민주 | 프론트엔드 개발 | AI 캐릭터와 대화, JWT 기반 사용자 인증 | [@Minju-3](https://github.com/Minju-3) |
| 류영주 | 프론트엔드 개발 | 작품 표지, 캐릭터 이미지 생성, 작품 후보 리스트업 등 | [@yeongju217](https://github.com/yeongju217) |
