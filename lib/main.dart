import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task3_flutter/app/modules/home/controllers/home_controller.dart';
import 'app/modules/home/views/home_view.dart';
 // تأكد من أن المسار صحيح

void main() async {

  await GetStorage.init();  // تهيئة GetStorage
  Get.put(HomeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
     // themeMode: ThemeMode.system,  // سيبدأ التطبيق حسب الثيم المحفوظ في التخزين
      home: HomeView(),
    );
  }
}
