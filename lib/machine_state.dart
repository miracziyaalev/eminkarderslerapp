import 'package:flutter/material.dart';

class MachinesState extends StatefulWidget {
  const MachinesState({Key? key}) : super(key: key);

  @override
  State<MachinesState> createState() => _MachinesStateState();
}

class _MachinesStateState extends State<MachinesState> {
  @override
  Widget build(BuildContext context) {
    var customHeight = MediaQuery.of(context).size.height;
    var customWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          height: customHeight * 0.3,
          width: customWidth * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
