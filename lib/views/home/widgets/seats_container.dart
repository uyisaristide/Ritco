import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class SeatsContainer extends StatefulWidget {
  final double? height;
  final double? width;
  final int id;
  final bool available;
  const SeatsContainer(
      {super.key,
      this.width = 17.5,
      this.height = 19,
      required this.id,
      this.available = true});

  @override
  State<SeatsContainer> createState() => _SeatsContainerState();
}

class _SeatsContainerState extends State<SeatsContainer> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return
        // InkWell(
        // onTap: () {
        //   setState(() {
        //     isSelected = !isSelected;
        //   });
        // },
        // child:
        Container(
      margin: const EdgeInsets.only(right: 3),
      height: widget.height,
      width: widget.width,
      color: widget.available ? primarySwatch : Colors.orange,
      child: Center(
          child: Text(
        '${widget.id}',
        style: const TextStyle(color: Colors.white,fontSize: 10),
      )),
    );
    // );
  }
}
