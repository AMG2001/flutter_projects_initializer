import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitializerController extends GetxController {
  late BuildContext context;
  late String projectPath;
  TextEditingController tec = TextEditingController();
  InitializerController({required this.context});

  String _path_pages = '';
  String _path_home_page = '';
  String _path_assets = '';
  String _path_mainFile = '';
  String _path_lib = '';

  @override
  void onInit() {
    Timer(Duration(seconds: 1), () {
      showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Enter Project path"),
                    Container(
                      padding: EdgeInsets.all(24),
                      child: TextField(
                        controller: tec,
                        decoration: InputDecoration(
                          labelText: 'Project Path',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (tec.text.isNotEmpty) {
                            projectPath = tec.text;
                            _path_assets = '${projectPath}/assets';
                            _path_lib = '${projectPath}/lib';
                            _path_pages = '${projectPath}/lib/Pages/';
                            _path_home_page =
                                '${projectPath}/lib/Pages/home_page';
                            createMainDartFileWithCode();
                            createFolders();
                          }
                        },
                        child: Text("Initialize"))
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
    super.onInit();
  }

  /**
   * is to create main.dart with mine initiale code .
   */
  void createMainDartFileWithCode() {
    final newFile = File('${projectPath}/lib/main.dart');
    newFile.create().then((file) {
      // Write some code to the file
      file
          .writeAsString("""
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
""")
          .then((_) => print('Code written to main.dart successfully!'))
          .catchError((e) => print('Error writing code to file main.dart: $e'));
    }).catchError((e) => print('Error creating file main.dart: $e'));
  }

  /**
   * is to create other files.dart
   */
  void createDartFileWithCode(
      {required String fileName,
      required String filePath,
      required String code}) {
    final newFile = File('$filePath/${fileName}.dart');
    newFile.create().then((file) {
      // Write some code to the file
      file
          .writeAsString(code)
          .then((_) => print('Code written to ${fileName} successfully!'))
          .catchError(
              (e) => print('Error writing code to file ${fileName}: $e'));
    }).catchError((e) => print('Error creating file ${fileName}: $e'));
  }

  void createFolders() {
    createAssetsFolder();
    createConfigFolder_with_device_dimensions_file();
    createPagesFolder_with_home_page();
  }

  void createPagesFolder_with_home_page() {
    /***
     * ********************* Create Pages folder **************************
     */
    var dir1 = Directory(_path_pages);
    dir1
        .create()
        .catchError((e) => print('Error while creating Pages folder : $e'));

    /***
     * ********************* Create home_page folder **************************
     */
    dir1 = Directory(_path_home_page);
    dir1
        .create()
        .catchError((e) => print('Error while creating home_page folder : $e'));
    /**
     * ********************* create home_page.dart file with initial code .
     */
    createDartFileWithCode(
        fileName: 'home_page', filePath: _path_home_page, code: """
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceDimensions.init();
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}

""");
  }

  void createAssetsFolder() {
    /***
     * ********************* Create assets folder **************************
     */
    var dir1 = Directory(_path_assets);
    dir1
        .create()
        .catchError((e) => print('Error while creating assets folder : $e'));
  }

  void createConfigFolder_with_device_dimensions_file() {
    /**
     * *********************** Create config folder ******************
     */
    var dir1 = Directory('${_path_lib}/config');
    dir1
        .create()
        .catchError((e) => print('Error while creating Pages folder : $e'));
    /**
         * ********************** Create device_dimensions.dart file with initial code .
         */
    createDartFileWithCode(
        fileName: 'home_page', filePath: '${_path_lib}/config', code: """
import 'package:get/get.dart';

class DeviceDimensions {
  static late double width;
  static late double height;
  static void init() {
    width = Get.mediaQuery.size.width;
    height = Get.mediaQuery.size.height;
  }
}

""");
  }
}
