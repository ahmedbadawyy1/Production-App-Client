import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footwareclient/controller/login_controller.dart';
import 'package:footwareclient/firebase_option.dart';
import 'package:footwareclient/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/home_controller.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  Get.put(LoginController());
  Get.put(HomeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
