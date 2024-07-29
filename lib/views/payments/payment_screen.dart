import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/_assets.dart';
import '../../theme/colors.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  Future<void> _launch(Uri url) async {
    try {
      if (!await launchUrl(url,
          mode: Platform.isIOS
              ? LaunchMode.platformDefault
              : LaunchMode.externalApplication)) {
        throw 'Could not launch';
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nyabugogo - Rusizi"),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(3)),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            padding: const EdgeInsets.all(0.2),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3))),
                onPressed: () {
                  final Uri uri = Uri(
                    scheme: 'tel',
                    path: '*182*8*1*44203#',
                  );
                  _launch(uri);
                  context.go('/success');
                },
                child: Row(
                  children: [
                    Image.asset(
                      AssetsUtils.mtnLogo,
                      height: 60,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Pay with MoMo",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.black,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
