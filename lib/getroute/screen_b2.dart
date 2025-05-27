import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class ScreenB2 extends StatelessWidget {
  const ScreenB2({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic args = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Screen B2')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('This is Screen B2', style: TextStyle(fontSize: 20)),
              if (args != null) ...[
                SizedBox(height: 10),
                Text(
                  'Received parameters: $args',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Go to Screen B3'),
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.screenB3PathDef,
                    arguments: {'detail': 'From B2 with love'},
                  );
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Go Back to B1'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
