import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class ScreenB3 extends StatelessWidget {
  const ScreenB3({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Screen B3')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('This is Screen B3 (End of Path B)', style: TextStyle(fontSize: 20)),
              if (args != null) ...[
                SizedBox(height: 10),
                Text('Received parameters: $args', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Jump to Screen A2'),
                onPressed: () {
                  // Option 1: Just go to A2, keeping B-stack
                  // Get.toNamed(Routes.SCREEN_A2, arguments: 'Jumped from B3 to A2');

                  // Option 2: Go to A2 and remove all previous routes (B-stack and any before it)
                  // This makes A2 the new root of the navigation stack.
                  Get.offAllNamed(AppRoutes.screenA2PathDef, arguments: 'Jumped from B3 to A2, cleared B-stack');
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Go Back to B2'),
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Go to Home (A1)'),
                onPressed: () {
                  Get.offAllNamed(AppRoutes.screenA1, arguments: 'Returned to Home from B3');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}