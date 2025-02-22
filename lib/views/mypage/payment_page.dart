import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storymate/view_models/mypage/payment_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final PaymentController controller = Get.put(PaymentController());
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
    final int productId = Get.arguments?['productId'] ?? 0;
    controller.preparePayment(productId);
  }

  void _initializeWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            controller.currentUrl.value = request.url; // 현재 URL 상태 업데이트
            print("현재 요청된 URL: ${request.url}");

            // 실제 pg_token 포함된 리디렉션 감지
            if (request.url.contains('pg_token')) {
              final Uri uri = Uri.parse(request.url);
              final String? pgToken = uri.queryParameters['pg_token'];
              if (pgToken != null) {
                print("결제 승인용 pg_token 수신: $pgToken");
                controller.approvePayment(pgToken);
              }
              return NavigationDecision.prevent;
            }

            // 결제 실패 감지
            else if (request.url.contains('fail')) {
              print("결제 실패 URL 감지");
              Get.offNamed('/payment/fail');
              return NavigationDecision.prevent;
            }

            // 잘못된 URL 로드 시 재시도
            else if (request.url.isEmpty || !request.url.startsWith('https')) {
              print("잘못된 URL 형식 감지: ${request.url}");
              return NavigationDecision.prevent;
            }

            // 기본적으로 이동 허용
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            print("페이지 로딩 완료: $url");
          },
          onWebResourceError: (WebResourceError error) {
            print("웹 리소스 에러 발생: ${error.description}");
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('카카오페이 결제')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.paymentUrl.value.isNotEmpty) {
          _webViewController
              .loadRequest(Uri.parse(controller.paymentUrl.value));
          return WebViewWidget(controller: _webViewController);
        } else {
          return const Center(child: Text('유효한 결제 URL을 받지 못했습니다.'));
        }
      }),
    );
  }
}
