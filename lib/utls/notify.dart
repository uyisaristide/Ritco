import 'package:flutter/material.dart';

import '../constants/_dimens.dart';

showWidgetDialog(double width, context, Widget widget,
    {bool overlay = true, bool overlayDismiss = true}) async {
  showGeneralDialog(
      context: context,
      barrierDismissible: overlayDismiss,
      barrierLabel: "widget",
      barrierColor:
      overlay ? Colors.black.withOpacity(.5) : Colors.black.withOpacity(.1),
      pageBuilder: (BuildContext context, anim1, anim2) {
        return Align(
          alignment:
          isSmall2(context) ? Alignment.center : Alignment.bottomCenter,
          child: Dismissible(
            key: const Key("dismiss"),
            direction: DismissDirection.down,
            onDismissed: (d) {
              Navigator.pop(context);
            },
            child: SafeArea(
              bottom: isSmall2(context),
              child: Flex(
                mainAxisSize: MainAxisSize.min,
                direction: Axis.vertical,
                children: [
                  Container(
                    height: 4,
                    width: 60,
                    margin: const EdgeInsets.only(bottom: 5, top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.8),
                        borderRadius: BorderRadius.circular(60)),
                  ),
                  Flexible(
                    child: Padding(
                      padding: isSmall2(context)
                          ? const EdgeInsets.only(bottom: 20)
                          : EdgeInsets.zero,
                      child: Material(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: width < ScreenWidth.extraSmall660
                                ? const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))
                                : const BorderRadius.all(Radius.circular(16))),
                        child: SizedBox(
                          width: width >= ScreenWidth.medium1050
                              ? width / 1.9
                              : width >= ScreenWidth.small
                              ? width / 1.7
                              : width >= ScreenWidth.extraSmall660
                              ? width / 1.5
                              : width,
                          child: widget,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(anim1),
            child: child);
      });
}
