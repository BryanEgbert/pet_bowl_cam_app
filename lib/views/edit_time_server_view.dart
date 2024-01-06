import 'package:flutter/material.dart';
import 'package:pet_bowl_cam_app/main.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_api_store.dart';

class EditTimeServerView extends StatelessWidget {
  const EditTimeServerView(
      {super.key,
      required this.timeServer1,
      required this.timeServer2,
      required this.timeServer3,
      required this.store});

  final String timeServer1;
  final String timeServer2;
  final String timeServer3;

  final PetBowlCamAPIStore store;

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstTimeServerController =
        TextEditingController(text: timeServer1);
    final TextEditingController secondTimeServerController =
        TextEditingController(text: timeServer2);
    final TextEditingController thirdTimeServerController =
        TextEditingController(text: timeServer3);

    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: firstTimeServerController,
                decoration: InputDecoration(
                    labelText: "Time server 1",
                    hintText:
                        (timeServer1.isEmpty) ? "pool.ntp.org" : timeServer1),
              ),
              TextField(
                controller: secondTimeServerController,
                decoration: const InputDecoration(labelText: "Time server 2"),
              ),
              TextField(
                controller: thirdTimeServerController,
                decoration: const InputDecoration(labelText: "Time server 3"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          store.updateTimeServer(
                              firstTimeServerController.value.text,
                              secondTimeServerController.value.text,
                              thirdTimeServerController.value.text);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(
                                selectedIndex: 1,
                              ),
                            ),
                          );
                        },
                        child: const Text("Save/Resubmit")),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
