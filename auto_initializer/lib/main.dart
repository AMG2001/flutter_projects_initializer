import 'dart:io';

import 'package:auto_initializer/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  double screenHeight = 600;
  double screenWidth = 450;
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setMinimumSize(Size(screenWidth, screenHeight));
    WindowManager.instance.setMaximumSize(Size(screenWidth, screenHeight));
  }
  runApp(AutoInitializer());
}

class AutoInitializer extends StatelessWidget {
  const AutoInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto Initializer',
      home: HomePage(),
    );
  }
}
