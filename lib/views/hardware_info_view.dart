import 'package:flutter/material.dart';
import 'package:pet_bowl_cam_app/model/hardware.dart';

class HardwareInfoView extends StatelessWidget {
  const HardwareInfoView({super.key, required this.hardwareInfo});

  final Hardware hardwareInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PetBowlCam App"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Material(
        child: ListView.custom(
            childrenDelegate: SliverChildListDelegate.fixed([
          ListTile(
            title: const Text("Chip Model"),
            subtitle: Text(hardwareInfo.chipModel),
          ),
          ListTile(
            title: const Text("Chip Cores"),
            subtitle: Text(hardwareInfo.chipCores.toString()),
          ),
          ListTile(
            title: const Text("Chip Revision"),
            subtitle: Text(hardwareInfo.chipRevision.toString()),
          ),
          ListTile(
            title: const Text("Flash Chip Mode"),
            subtitle: Text(hardwareInfo.flashChipMode),
          ),
          ListTile(
            title: const Text("Flash Chip Size"),
            subtitle: Text(hardwareInfo.flashChipSize.toString()),
          ),
          ListTile(
            title: const Text("Flash Chip Speed"),
            subtitle: Text(hardwareInfo.flashChipSpeed.toString()),
          ),
          ListTile(
            title: const Text("MAC Address"),
            subtitle: Text(hardwareInfo.macAddress.toString()),
          ),
          ListTile(
            title: const Text("Heap Size"),
            subtitle: Text(hardwareInfo.heapSize.toString()),
          ),
          ListTile(
            title: const Text("Free Heap Size"),
            subtitle: Text(hardwareInfo.freeHeapSize.toString()),
          ),
          ListTile(
            title: const Text("PSRAM Size"),
            subtitle: Text(hardwareInfo.psramSize.toString()),
          ),
          ListTile(
            title: const Text("Free PSRAM Size"),
            subtitle: Text(hardwareInfo.freePsramSize.toString()),
          ),
          ListTile(
            title: const Text("SDK Version"),
            subtitle: Text(hardwareInfo.sdkVersion),
          ),
        ])),
      ),
    );
  }
}
