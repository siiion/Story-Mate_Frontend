import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:storymate/components/theme.dart';
import 'package:storymate/view_models/mypage/payment_controller.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;
  late int amount;

  @override
  void initState() {
    super.initState();
    amount = Get.arguments?['amount'] ?? 500; // 기본값 500원 설정

    _paymentWidget = PaymentWidget(
      clientKey: "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm",
      customerKey: "hvDepv1HDm6Dne-B33jj5",
    );

    _paymentWidget
        .renderPaymentMethods(
      selector: 'methods',
      amount: Amount(value: amount, currency: Currency.KRW, country: "KR"),
      options: RenderPaymentMethodsOptions(variantKey: "DEFAULT"),
    )
        .then((control) {
      _paymentMethodWidgetControl = control;
    });

    _paymentWidget.renderAgreement(selector: 'agreement').then((control) {
      _agreementWidgetControl = control;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: const Text(
          '메시지 충전',
          style: TextStyle(
            fontFamily: 'Jua',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '충전 금액',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$amount원',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Divider(
                      color: Color(0xffa2a2a2),
                    ),
                  ),
                  PaymentMethodWidget(
                    paymentWidget: _paymentWidget,
                    selector: 'methods',
                  ),
                  AgreementWidget(
                      paymentWidget: _paymentWidget, selector: 'agreement'),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        final paymentResult =
                            await _paymentWidget.requestPayment(
                          paymentInfo: PaymentInfo(
                            orderId:
                                'order_${DateTime.now().millisecondsSinceEpoch}',
                            orderName:
                                '메시지 ${amount == 500 ? "30개" : "70개"} 충전',
                          ),
                        );
                        if (paymentResult.success != null) {
                          // 결제 성공 처리
                          Get.snackbar('결제 성공', '결제가 완료되었습니다.',
                              snackPosition: SnackPosition.BOTTOM);
                          Get.back(); // 결제 완료 후 이전 화면으로 이동
                        } else if (paymentResult.fail != null) {
                          // 결제 실패 처리
                          Get.snackbar('결제 실패', '결제에 실패했습니다.',
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      },
                      child: Container(
                        width: 300.w,
                        height: 60.h,
                        decoration: ShapeDecoration(
                          color: Color(0xFF9B9ECF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '결제하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontFamily: 'Jua',
                              fontWeight: FontWeight.w400,
                              height: 1,
                              letterSpacing: -0.23,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
