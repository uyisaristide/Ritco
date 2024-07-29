import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ritco_app/constants/_assets.dart';
import 'package:ritco_app/theme/colors.dart';

import '../../utls/styles.dart';
import '../auth/widgets/authentication_button.dart';
import '../home/widgets/cover_container.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Success"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 35,
        ),
        // height: MediaQuery.of(context).size.height / 1.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CoverContainer(children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(
              AssetsUtils.success,
              height: 60,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
                'Thank you for booking a trip with us, we will send you a confirmation SMS shortly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                )),
            const SizedBox(
              height: 20,
            ),
            const Text('Remember to pay for your tickets within 15 mins',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            const SizedBox(
              height: 30,
            ),
            // ]),

            // Spacer(),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                onPressed: () {
                  // context.go("/failed");
                  context.go("/home");
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ok",
                      style: TextStyle(
                          color: primarySwatch, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
