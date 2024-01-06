import 'package:flutter/material.dart';
import 'package:pet_bowl_cam_app/main.dart';
import 'package:pet_bowl_cam_app/model/servo.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_api_store.dart';

class EditServoView extends StatefulWidget {
  const EditServoView(
      {super.key, required this.store, required this.initialInfo});

  final PetBowlCamAPIStore store;
  final Servo initialInfo;

  @override
  State<EditServoView> createState() => _EditServoViewState();
}

class _EditServoViewState extends State<EditServoView> {
  TextEditingController textEditController = TextEditingController();
  bool openOnTimeout = false;

  @override
  void initState() {
    openOnTimeout = widget.initialInfo.openOnTimeout;
    textEditController =
        TextEditingController(text: widget.initialInfo.servoOpenMs.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textEditController,
                decoration: const InputDecoration(
                    labelText: "Servo open duration (ms)"),
                keyboardType: TextInputType.number,
              ),
            ),
            CheckboxListTile(
              title: const Text("Should open servo on AI server HTTP timeout"),
              value: openOnTimeout,
              onChanged: (value) {
                setState(() {
                  openOnTimeout = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                widget.store.updateServoConfig(
                    openOnTimeout, int.parse(textEditController.value.text));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(
                      selectedIndex: 1,
                    ),
                  ),
                );
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
