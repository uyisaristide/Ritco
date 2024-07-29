import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String questionText;
  final String directingText;
  final VoidCallback onTap;
  const CustomTextButton(
      {super.key,
      required this.questionText,
      required this.onTap,
      required this.directingText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questionText,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: TextButton(
                  onPressed: onTap,
                  // style:
                  //     StyleUtils.commonButtonStyle,
                  child: Text(
                    directingText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
