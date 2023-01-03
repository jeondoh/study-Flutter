import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order_app/common/const/colors.dart';
import 'package:order_app/common/layout/default_layout.dart';
import 'package:order_app/common/view/root_tab.dart';

class OrderDoneScreen extends StatelessWidget {
  static String get routeName => 'orderDone';

  const OrderDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.thumb_up_alt_outlined,
              color: PRIMARY_COLOR,
              size: 50.0,
            ),
            const SizedBox(height: 32.0),
            const Text('결제가 완료되었습니다.', textAlign: TextAlign.center),
            const SizedBox(height: 32.0),
            ElevatedButton(
                onPressed: () {
                  context.goNamed(RootTab.routeName);
                },
                style: ElevatedButton.styleFrom(primary: PRIMARY_COLOR),
                child: const Text('홈으로')),
          ],
        ),
      ),
    );
  }
}
