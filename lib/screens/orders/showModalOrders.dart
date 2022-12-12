import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var customWidth = MediaQuery.of(context).size.width;
    var customHeight = MediaQuery.of(context).size.height;
    int screenValue = 2;

    return InkWell(
      onTap: onPressed,
      child: Container(
          height: customHeight * 0.5,
          width: customWidth * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey[600],
          ),
          child: const Icon(
            Icons.keyboard_double_arrow_down_outlined,
            size: 50,
          )),
    );
  }
}
