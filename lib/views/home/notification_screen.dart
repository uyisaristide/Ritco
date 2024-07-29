import 'package:flutter/material.dart';
import 'package:ritco_app/constants/_assets.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                        child: Image.asset(
                        AssetsUtils.notifications,
                        fit: BoxFit.cover,
                        height: 70,
                        width: 70,
                      )),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "You have  no new notification",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
    );
  }
}
