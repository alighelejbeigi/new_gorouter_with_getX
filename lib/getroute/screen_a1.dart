import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart'; // For route names

class ScreenA1 extends StatelessWidget {
  const ScreenA1({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Screen A1')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('This is Screen A1', style: TextStyle(fontSize: 20)),
              if (args != null) ...[
                SizedBox(height: 10),
                Text('Received parameters: $args', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Go to Screen A2'),
                onPressed: () {
                  Get.toNamed(AppRoutes.screenA2PathDef, arguments: {'message': 'Hello from A1', 'timestamp': DateTime.now().toIso8601String()});
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Start Path B (Go to B1)'),
                onPressed: () {
                  Get.toNamed(AppRoutes.screenB2PathDef, arguments: 'Initiating Path B from A1');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}