import 'package:flutter/material.dart';
import 'package:pet_bowl_cam_app/main.dart';
import 'package:pet_bowl_cam_app/model/wifi.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_api_store.dart';

class EditWiFiView extends StatelessWidget {
  const EditWiFiView(
      {super.key, required this.store, required this.initialValue});

  final PetBowlCamAPIStore store;
  final WiFi initialValue;

  @override
  Widget build(BuildContext context) {
    final TextEditingController ssidEditController =
        TextEditingController(text: initialValue.ssid);
    final TextEditingController passwordEditController =
        TextEditingController(text: initialValue.password);

    return Material(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: ssidEditController,
              decoration: const InputDecoration(labelText: "SSID"),
            ),
            TextField(
              controller: passwordEditController,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        store.updateWiFi(ssidEditController.value.text,
                            passwordEditController.value.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(
                              selectedIndex: 1,
                            ),
                          ),
                        );
                      },
                      child: const Text("Save")),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
