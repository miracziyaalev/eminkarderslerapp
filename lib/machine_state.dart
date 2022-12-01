import 'package:eminkardeslerapp/core/constants.dart';
import 'package:eminkardeslerapp/core/core_padding.dart';
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
    final borderRadius = BorderRadius.circular(20); // Image border
    var assetsimagejpg = 'assets/image.jpg';
    const name = "Miraç Ziya ALEV";
    const machine = "CT - 2";
    const operation = "DİPÇİK TÜPÜ";
    var stateMachine = Colors.green;

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              const infoStateWidget(),
              Expanded(
                flex: 5,
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: const EdgeInsets.all(20),
                  children: [
                    machineStateCardWidget(
                        customHeight: customHeight,
                        customWidth: customWidth,
                        stateMachine: stateMachine,
                        borderRadius: borderRadius,
                        assetsimagejpg: assetsimagejpg,
                        name: name,
                        machine: machine,
                        operation: operation),
                    machineStateCardWidget(
                        customHeight: customHeight,
                        customWidth: customWidth,
                        stateMachine: stateMachine,
                        borderRadius: borderRadius,
                        assetsimagejpg: assetsimagejpg,
                        name: name,
                        machine: machine,
                        operation: operation),
                    machineStateCardWidget(
                        customHeight: customHeight,
                        customWidth: customWidth,
                        stateMachine: stateMachine,
                        borderRadius: borderRadius,
                        assetsimagejpg: assetsimagejpg,
                        name: name,
                        machine: machine,
                        operation: operation),
                    machineStateCardWidget(
                        customHeight: customHeight,
                        customWidth: customWidth,
                        stateMachine: Colors.grey,
                        borderRadius: borderRadius,
                        assetsimagejpg: assetsimagejpg,
                        name: name,
                        machine: machine,
                        operation: operation),
                    machineStateCardWidget(
                        customHeight: customHeight,
                        customWidth: customWidth,
                        stateMachine: stateMachine,
                        borderRadius: borderRadius,
                        assetsimagejpg: assetsimagejpg,
                        name: name,
                        machine: machine,
                        operation: operation),
                    machineStateCardWidget(
                        customHeight: customHeight,
                        customWidth: customWidth,
                        stateMachine: stateMachine,
                        borderRadius: borderRadius,
                        assetsimagejpg: assetsimagejpg,
                        name: name,
                        machine: machine,
                        operation: operation),
                    machineStateCardWidget(
                        customHeight: customHeight,
                        customWidth: customWidth,
                        stateMachine: Colors.red,
                        borderRadius: borderRadius,
                        assetsimagejpg: assetsimagejpg,
                        name: name,
                        machine: machine,
                        operation: operation),
                    machineStateCardWidget(
                        customHeight: customHeight,
                        customWidth: customWidth,
                        stateMachine: stateMachine,
                        borderRadius: borderRadius,
                        assetsimagejpg: assetsimagejpg,
                        name: name,
                        machine: machine,
                        operation: operation),
                    machineStateCardWidget(
                        customHeight: customHeight,
                        customWidth: customWidth,
                        stateMachine: stateMachine,
                        borderRadius: borderRadius,
                        assetsimagejpg: assetsimagejpg,
                        name: name,
                        machine: machine,
                        operation: operation),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class infoStateWidget extends StatelessWidget {
  const infoStateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: ProjectPaddingCore().paddingAllMedium,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: Constants.cardBorderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: Constants.cardBorderRadius,
                          color: Colors.green,
                        ),
                        child: const Center(
                          child: Text(
                            "ÜRETİM",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: Constants.cardBorderRadius,
                        color: Colors.red,
                      ),
                      child: const Center(
                          child: Text(
                        "DURUŞ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: Constants.cardBorderRadius,
                        color: Colors.grey,
                      ),
                      child: const Center(
                          child: Text(
                        "BOŞ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class machineStateCardWidget extends StatelessWidget {
  const machineStateCardWidget({
    Key? key,
    required this.customHeight,
    required this.customWidth,
    required this.stateMachine,
    required this.borderRadius,
    required this.assetsimagejpg,
    required this.name,
    required this.machine,
    required this.operation,
  }) : super(key: key);

  final double customHeight;
  final double customWidth;
  final MaterialColor stateMachine;
  final BorderRadius borderRadius;
  final String assetsimagejpg;
  final String name;
  final String machine;
  final String operation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: customHeight * 0.4,
      width: customWidth * 0.3,
      padding: const EdgeInsets.all(8), // Border width
      decoration:
          BoxDecoration(color: stateMachine, borderRadius: borderRadius),
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: borderRadius,
              ),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Image(
                  image: AssetImage(assetsimagejpg),
                  fit: BoxFit.cover,
                  width: customWidth,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 50,
                    child: Center(
                        child: Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                  )),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: Center(
                        child: Text(
                      machine,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                  )),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: Center(
                        child: Text(
                      operation,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
