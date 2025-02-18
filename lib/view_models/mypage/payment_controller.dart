// import 'package:get/get.dart';
// import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
// import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
// import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
// import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
// import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';

// class PaymentController extends GetxController {
//   late PaymentWidget paymentWidget;
//   PaymentMethodWidgetControl? paymentMethodWidgetControl;
//   AgreementWidgetControl? agreementWidgetControl;

//   // 결제 금액을 Get.arguments로 받음
//   final int amount = Get.arguments?['amount'] ?? 500;

//   @override
//   void onInit() {
//     super.onInit();

//     // 토스페이먼츠 위젯 초기화
//     paymentWidget = PaymentWidget(
//       clientKey: "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm",
//       customerKey: "hvDepv1HDm6Dne-B33jj5",
//     );

//     // 결제 수단 렌더링
//     paymentWidget
//         .renderPaymentMethods(
//       selector: 'methods',
//       amount: Amount(value: amount, currency: Currency.KRW, country: "KR"),
//       options: RenderPaymentMethodsOptions(variantKey: "DEFAULT"),
//     )
//         .then((control) {
//       paymentMethodWidgetControl = control;
//     });

//     // 약관 렌더링
//     paymentWidget.renderAgreement(selector: 'agreement').then((control) {
//       agreementWidgetControl = control;
//     });
//   }

//   // 결제 요청 함수
//   Future<void> requestPayment() async {
//     final paymentResult = await paymentWidget.requestPayment(
//       paymentInfo: PaymentInfo(
//         orderId: 'order_${DateTime.now().millisecondsSinceEpoch}',
//         orderName: '메시지 ${amount == 500 ? "30개" : "70개"} 충전',
//       ),
//     );

//     if (paymentResult.success != null) {
//       // 결제 성공 시 성공 페이지로 이동
//       Get.offNamed('/my_page/payments/success', arguments: {"amount": amount});
//     } else if (paymentResult.fail != null) {
//       // 결제 실패 시 실패 페이지로 이동
//       Get.offNamed('/my_page/payments/fail',
//           arguments: {"reason": paymentResult.fail.toString()});
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentController extends GetxController {
  final InAppPurchase _iap = InAppPurchase.instance;
  final RxList<ProductDetails> products = <ProductDetails>[].obs;
  final RxInt amount = 0.obs; // 현재 충전 금액

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  /// 인앱 결제 초기화 및 상품 로드
  Future<void> _initialize() async {
    final bool available = await _iap.isAvailable();
    if (!available) {
      print("In-App Purchases not available.");
      return;
    }

    // 구매 가능한 상품 ID (App Store / Play Store에서 설정한 ID)
    const Set<String> productIds = {
      'message_1000',
      'message_5000',
      'message_10000'
    };

    final ProductDetailsResponse response =
        await _iap.queryProductDetails(productIds);

    if (response.notFoundIDs.isNotEmpty) {
      print("Some products not found: ${response.notFoundIDs}");
    }

    products.assignAll(response.productDetails);
  }

  /// 상품 구매 요청
  void purchaseProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    await _iap.buyConsumable(purchaseParam: purchaseParam);
  }

  /// 구매 복원
  void restorePurchases() async {
    await _iap.restorePurchases();
  }
}
