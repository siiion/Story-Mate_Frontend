import 'package:get/get.dart';

class TermsController extends GetxController {
  var allChecked = false.obs;
  var serviceAgreement = false.obs;
  var privacyAgreement = false.obs;
  var marketingAgreement = false.obs;

  // 개별 체크박스 상태 변경 함수
  void toggleServiceAgreement() {
    serviceAgreement.value = !serviceAgreement.value;
    updateAllCheckedStatus();
  }

  void togglePrivacyAgreement() {
    privacyAgreement.value = !privacyAgreement.value;
    updateAllCheckedStatus();
  }

  void toggleMarketingAgreement() {
    marketingAgreement.value = !marketingAgreement.value;
    updateAllCheckedStatus();
  }

  // 모든 필수 체크박스가 체크되었는지 확인
  bool isAllRequiredChecked() {
    return serviceAgreement.value && privacyAgreement.value;
  }

  // 모두 동의 체크박스 상태 업데이트
  void updateAllCheckedStatus() {
    allChecked.value = serviceAgreement.value &&
        privacyAgreement.value &&
        marketingAgreement.value;
  }

  // 전체 동의 체크박스 클릭 시 동작
  void toggleAllAgreement() {
    bool newValue = !allChecked.value;
    serviceAgreement.value = newValue;
    privacyAgreement.value = newValue;
    marketingAgreement.value = newValue;
    allChecked.value = newValue;
  }

  // 서비스 이용 약관 전문 보기
  void toServiceTermsDetail() {
    Get.toNamed('/terms/detail', arguments: {
      'title': '서비스 이용 약관',
      'content': '''서비스 이용약관

제1조 목적
본 이용약관은 “Story Mate”(이하 "사이트")의 서비스 이용 조건과 운영에 관한 제반 사항 규정을 목적으로 합니다.

제2조 용어의 정의
본 약관에서 사용되는 주요 용어의 정의는 다음과 같습니다. 
① 회원 : 사이트의 약관에 동의하고 개인정보를 제공하여 회원으로 등록된 자로서, 사이트와의 이용계약을 체결하고 사이트를 이용하는 이용자를 말합니다. 
② 이용계약 : 사이트 이용과 관련하여 사이트와 회원 간에 체결하는 계약을 말합니다.
③ 해지 : 회원이 이용계약을 해약하는 것을 말합니다. 
④ 운영자 : 사이트의 서비스를 관리하고 운영하는 자를 말합니다.

제3조 약관 외 준칙
운영자는 필요한 경우 별도로 운영정책을 공지 안내할 수 있으며, 본 약관과 운영정책이 중첩될 경우 운영정책이 우선 적용됩니다.

제4조 이용계약 체결
① 이용계약은 회원으로 등록하여 사이트를 이용하려는 자의 본 약관 내용에 대한 동의와 가입신청에 대해 운영자의 이용승낙으로 성립합니다. 
② 회원으로 등록하여 서비스를 이용하려는 자는 가입신청 시 본 약관을 읽고 "동의합니다"를 선택하는 것으로 본 약관에 대한 동의 의사를 표시합니다.

제5조 서비스 이용 신청 
① 회원으로 등록하여 사이트를 이용하려는 이용자는 사이트에서 요청하는 제반 정보**(이름, 생년월일 등)**를 제공해야 합니다. 
② 타인의 정보를 도용하거나 허위 정보를 등록하는 등 본인의 진정한 정보를 등록하지 않은 회원은 사이트 이용과 관련하여 아무런 권리를 주장할 수 없으며, 관계 법령에 따라 처벌받을 수 있습니다.

제6조 개인정보처리방침 
사이트 및 운영자는 회원 가입 시 제공한 개인정보와 위치 정보를 수집, 관리하며, 이와 관련된 부분은 사이트의 개인정보처리방침에 따릅니다. 운영자는 관계 법령이 정하는 바에 따라 회원의 개인정보와 위치 정보를 보호하기 위해 노력합니다.

제7조 운영자의 의무 
① 운영자는 이용 회원으로부터 제기되는 의견이나 불만이 정당하다고 인정할 경우 신속하게 처리하며, 처리에 시간이 소요되는 경우 공지 또는 개별 통지를 통해 안내합니다. 
② 운영자는 사이트 서비스의 안정적인 제공을 위하여 노력하며, 천재지변 등 부득이한 사유가 있을 경우 일시적으로 서비스 제공을 중지할 수 있습니다.

제8조 회원의 의무 
① 회원은 본 약관, 운영자가 정한 제반 규정, 공지사항 및 관계 법령을 준수하여야 하며, 사이트의 명예를 손상시키는 행위를 해서는 안 됩니다. 
② 회원은 사이트의 명시적 동의 없이 이용 권한을 타인에게 양도할 수 없습니다. 
③ 회원은 이름과 생년월일을 관리하며, 운영자나 사이트의 동의 없이 제3자에게 제공할 수 없습니다.

제9조 서비스 이용 시간 
서비스 이용 시간은 연중무휴 1일 24시간을 원칙으로 하며, 시스템 정기점검 시 서비스가 일시 중단될 수 있으며, 예정된 작업은 사전에 공지합니다.

제10조 서비스 이용 해지 
회원이 사이트 이용 계약을 해지하고자 할 경우 온라인을 통해 해지 신청을 해야 하며, 신청과 동시에 해당 회원의 정보를 삭제하여 더 이상 운영자가 이를 볼 수 없습니다.

제11조 서비스 이용 제한 
회원이 다음 각 호에 해당하는 행위를 한 경우 사이트는 서비스 이용 제한 및 적법한 조치를 할 수 있으며, 이용계약을 해지하거나 서비스를 중지할 수 있습니다. 
① 허위 내용 등록 
② 타인의 사이트 이용을 방해하거나 정보를 도용하는 행위 
③ 사이트 운영진, 직원, 관계자를 사칭하는 행위 
④ 사이트의 인격권 또는 지적재산권을 침해하는 행위 
⑤ 타 회원의 개인정보를 무단으로 수집, 저장, 공개하는 행위 
⑥ 기타 관계 법령에 위배되는 행위

제15조 손해배상 
사이트 이용으로 인한 모든 법적 책임은 회원 본인에게 있으며, 불가항력으로 인한 손해는 배상하지 않습니다.

제16조 면책 
운영자는 천재지변, 회원의 고의나 과실, 통신서비스의 장애로 인한 손해에 대해 책임지지 않습니다. 회원이 게시한 자료에 대한 진위, 신뢰도 등에 대해서도 책임지지 않습니다.

부칙 이 약관은 <2025.02.XX>부터 시행합니다.'''
    });
  }

  // 개인정보 처리 방침 전문 보기
  void toPersonalInfoTermsDetail() {
    Get.toNamed('/terms/detail', arguments: {
      'title': '개인정보 처리방침',
      'content': '''개인정보 처리방침

제1조 (개인정보의 처리목적) 
Story Mate(이하 ‘회사’라 한다)는 개인정보 보호법 제30조에 따라 정보 주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립, 공개합니다. 회사는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

회원 가입 및 관리 
회원 가입 의사 확인, 회원제 서비스 제공에 따른 본인 식별 및 인증, 회원자격 유지 및 관리, 서비스 부정 이용 방지, 만 14세 미만 아동의 개인정보처리 시 법정대리인의 동의 여부 확인, 각종 고지 및 통지, 고충 처리 등을 목적으로 개인정보를 처리합니다.

서비스 제공 
맞춤서비스 제공, 콘텐츠 제공, 본인 인증, 요금 결제 및 정산 등을 목적으로 개인정보를 처리합니다.

고충 처리 
민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락 및 통지, 처리 결과 통보 등의 목적으로 개인정보를 처리합니다.

제2조 (개인정보의 처리 및 보유기간) 
① 회사는 법령에 따른 개인정보 보유, 이용 기간 또는 정보주체로부터 개인정보를 수집 시에 동의 받은 개인정보 보유, 이용 기간 내에서 개인정보를 처리, 보유합니다. 
② 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.

서비스 회원 가입 및 관리 : 
회원 탈퇴 시까지 보유 단, 다음의 사유에 해당하는 경우에는 해당 사유 종료 시까지 보유 관계 법령 위반에 따른 수사 및 조사 등이 진행 중인 경우에는 해당 수사 및 조사 종료 시까지 서비스 이용에 따른 채권 및 채무 관계 잔존 시에는 해당 채권, 채무 관계 정산 시까지 

제3조 (이용자 및 법정대리인의 권리와 그 행사 방법) 
① 정보주체는 회사에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.
- 개인정보 열람 요구 
- 오류 등이 있을 경우 정정 요구 
- 삭제 요구 
- 처리 정지 요구 
② 제1항에 따른 권리 행사는 회사에 대해 서면, 전화, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 회사는 이에 대해 지체 없이 조치하겠습니다. 
③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우, 회사는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다. 
④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 할 수 있습니다. 이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출해야 합니다. 
⑤ 정보주체는 개인정보 보호법 등 관계 법령을 위반하여 회사가 처리하고 있는 정보주체 본인이나 타인의 개인정보 및 사생활을 침해하여서는 아니 됩니다. 

제4조 (처리하는 개인정보 항목) 
회사는 다음의 개인정보 항목을 처리하고 있습니다.
회원 가입 및 관리 필수항목 : 
- 이름, 생년월일 선택항목 : [ ] 
인터넷 서비스 이용과정에서 자동으로 생성되어 수집될 수 있는 항목 IP주소, 쿠키, MAC 주소, 서비스 이용기록, 방문기록, 불량 이용기록 등 

제5조 (개인정보의 파기) 
① 회사는 개인정보 보유 기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때 지체 없이 해당 개인정보를 파기합니다. 
② 동의받은 개인정보 보유 기간이 경과하거나 처리목적이 달성되었음에도 불구하고 다른 법령에 따라 개인정보를 계속 보존해야 하는 경우, 해당 개인정보를 별도의 데이터베이스(DB)로 옮기거나 보관장소를 달리하여 보존합니다. 
③ 개인정보 파기의 절차 및 방법은 다음과 같습니다.
- 파기 절차: 파기 사유가 발생한 개인정보를 선정하고, 회사의 개인정보 보호책임자의 승인을 받아 개인정보를 파기합니다. 
- 파기 방법: 전자적 파일 형태로 기록된 개인정보는 로우레벨 포맷(Low Level Format) 등의 방법으로 파기하며, 종이 문서에 기록된 개인정보는 분쇄기로 분쇄하거나 소각하여 파기합니다. 

제6조 (개인정보의 안전성 확보조치) 
회사는 개인정보의 안전성 확보를 위해 다음과 같은 조치를 합니다.
- 관리적 조치 : 내부관리계획 수립 및 시행, 정기적 직원 교육 등 
- 기술적 조치 : 개인정보처리시스템 등의 접근 권한 관리, 접근통제 시스템 설치, 암호화, 보안프로그램 설치 
- 물리적 조치 : 전산실, 자료보관실 등의 접근 통제 

제7조 (개인정보 자동 수집 장치의 설치∙운영 및 거부에 관한 사항) 
① 회사는 이용자에게 개별 맞춤 서비스를 제공하기 위해 쿠키(cookie)를 사용합니다. 
② 쿠키는 웹사이트 운영 서버가 이용자의 컴퓨터 브라우저에 보내는 소량의 정보로, 이용자의 하드디스크에 저장될 수 있습니다.
- 쿠키의 사용 목적: 방문 및 이용 형태, 인기 검색어, 보안 접속 여부 등을 파악하여 최적화된 정보 제공 
- 쿠키의 설치 및 거부: 웹브라우저 설정에서 쿠키 저장을 거부할 수 있습니다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 있을 수 있습니다. 

제8조 (개인정보 보호책임자) 
① 회사는 개인정보 처리와 관련한 불만 처리 및 피해 구제를 위해 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.
- 개인정보 보호책임자 
    - 성명 : [ ] 
    - 직책 : [ ] 
    - 연락처 :[ ] 
- 개인정보 보호 담당부서 
    - 부서명 : [ ] 
    - 담당자 : [ ] 
    - 연락처 : [ ] 
② 정보주체는 개인정보 보호 관련 문의를 개인정보 보호책임자 및 담당부서로 문의할 수 있으며, 회사는 지체 없이 답변 및 처리해 드립니다. 

제9조 (개인정보 열람청구) 
정보주체는 개인정보 보호법 제35조에 따른 개인정보 열람 청구를 아래의 부서에 할 수 있으며, 회사는 신속한 처리를 위해 노력하겠습니다.
- 개인정보 열람청구 접수․처리 부서 : 개발팀 
    - 담당자 : [ ] 
    - 연락처 : [ ] 

제10조 (권익침해 구제 방법) 
정보주체는 아래 기관에 개인정보 침해에 대한 피해구제 및 상담을 문의할 수 있습니다.
- 개인정보 침해신고센터 
    - 홈페이지 : privacy.kisa.or.kr 
    - 전화 : (국번없이) 118 
- 개인정보 분쟁조정위원회 
    - 홈페이지 : www.kopico.go.kr 
    - 전화 : (국번없이) 1833-6972 

제13조 (개인정보 처리방침 시행 및 변경) 
이 개인정보 처리방침은 2025. 02. xx부터 적용됩니다.'''
    });
  }
}
