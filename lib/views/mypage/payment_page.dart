import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final WebViewController _webViewController;
  String? paymentUrl;
  late int amount;

  @override
  void initState() {
    super.initState();
    amount = Get.arguments?['amount'] ?? 500; // 전달받은 결제 금액

    // WebViewController 초기화
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('success')) {
              Get.offNamed('/payment/success');
              return NavigationDecision.prevent;
            } else if (request.url.contains('fail')) {
              Get.offNamed('/payment/fail');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    _requestKakaoPay(); // 카카오페이 결제 요청
  }

  // 카카오페이 결제 요청
  Future<void> _requestKakaoPay() async {
    final response = await http.post(
      Uri.parse('https://yourserver.com/api/kakaopay/request'), // 서버 API 주소
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "amount": amount,
        "orderId": "order_${DateTime.now().millisecondsSinceEpoch}",
        "userId": "1234",
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        paymentUrl = data['next_redirect_mobile_url']; // 카카오페이 결제 URL 저장
      });

      // WebView에 URL 로딩
      if (paymentUrl != null) {
        _webViewController.loadRequest(Uri.parse(paymentUrl!));
      }
    } else {
      print("결제 요청 실패: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('카카오페이 결제')),
      body: paymentUrl == null
          ? const Center(
              child: CircularProgressIndicator()) // 결제 URL을 받을 때까지 로딩 표시
          : WebViewWidget(controller: _webViewController), // 수정된 부분
    );
  }
}
