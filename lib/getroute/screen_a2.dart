import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class ScreenA2 extends StatelessWidget {
  const ScreenA2({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Screen A2')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('This is Screen A2', style: TextStyle(fontSize: 20)),
              if (args != null) ...[
                SizedBox(height: 10),
                Text('Received parameters: $args', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Go to Screen A3'),
                onPressed: () {
                  Get.toNamed(AppRoutes.screenA3PathDef, arguments: {'source': 'A2', 'data': [1, 2, 3]});
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Go Back to A1'),
                onPressed: () {
                  Get.back(result: 'Returned from A2');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}