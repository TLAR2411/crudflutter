import 'package:chat_app/my_data.dart';
import 'package:chat_app/register.dart';
import 'package:chat_app/sreen_form.dart';
import 'package:chat_app/todo.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  MyData d = MyData();
  Get.put(d);

  runApp(DevicePreview(builder: (context) => MyApp()));
  // runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final d = Get.find<MyData>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => Register()),
        GetPage(
          name: '/todo',
          // middlewares: [AuthMiddleware()],
          page: () => Todo(),
        ),
        // GetPage(name: '/', page: () => Register()),
      ],
      initialRoute: '/',
    );
  }
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    MyData d = Get.find<MyData>();
    final token = d.token;

    if (token.isEmpty) {
      return RouteSettings(name: '/login');
    }
    return null;
  }
}
