import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class ScreenA3 extends StatelessWidget {
  const ScreenA3({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Screen A3')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'This is Screen A3 (End of Path A)',
                style: TextStyle(fontSize: 20),
              ),
              if (args != null) ...[
                SizedBox(height: 10),
                Text(
                  'Received parameters: $args',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Go Back to A2'),
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Jump to Screen B2'),
                onPressed: () {
                  // This will add B2 to the stack.
                  // If you want to clear the A-stack and start B fresh, you might use:
                  // Get.offAllNamed(Routes.SCREEN_B2, arguments: 'Jumped from A3, cleared A-stack');
                  Get.toNamed(
                    AppRoutes.screenB2PathDef,
                    arguments: 'Jumped from A3 to B2',
                  );
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Go to Home (A1)'),
                onPressed: () {
                  Get.offAllNamed(
                    AppRoutes.screenA1,
                    arguments: 'Returned to Home from A3',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
