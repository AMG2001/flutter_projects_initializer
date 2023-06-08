import 'package:auto_initializer/config/device_dimensions.dart';
import 'package:auto_initializer/controller/initializer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController tec_projectPathController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DeviceDimensions.init();
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto Initializer"),
      ),
      body: GetBuilder<InitializerController>(
          init: InitializerController(context: context),
          builder: (controller) {
            return Container(
              height: DeviceDimensions.height,
              width: DeviceDimensions.width,
              child: Center(
                child: Text("Created by AMG"),
              ),
            );
          }),
    );
  }
}
