import 'package:flutter/material.dart';
import 'package:mobx/src/api/async.dart';
import 'package:pet_bowl_cam_app/model/feeding_schedule.dart';
import 'package:pet_bowl_cam_app/store/pet_bowl_cam_api_store.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.errorMessage,
    required this.refreshCallback,
  });

  final String errorMessage;
  final VoidCallback refreshCallback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Failed to load data",
          ),
          Text("Reason: $errorMessage"),
          IconButton(
            onPressed: refreshCallback,
            icon: const Icon(Icons.refresh_rounded),
          )
        ],
      ),
    );
  }
}
