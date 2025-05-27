import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class ScreenB1 extends StatelessWidget {
  const ScreenB1({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Screen B1')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('This is Screen B1', style: TextStyle(fontSize: 20)),
              if (args != null) ...[
                SizedBox(height: 10),
                Text('Received parameters: $args', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Go to Screen B2'),
                onPressed: () {
                  Get.toNamed(AppRoutes.screenB2PathDef, arguments: {'user': 'PathB_User', 'id': 789});
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Start Path A (Go to A1)'),
                onPressed: () {
                  Get.toNamed(AppRoutes.screenA1, arguments: 'Initiating Path A from B1');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}