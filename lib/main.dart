import 'package:chat_app/my_data.dart';
import 'package:chat_app/sreen_form.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  MyData d = MyData();
  Get.put(d);

  // runApp(DevicePreview(builder: (context) => MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // final MyData d = MyData();
    final d = Get.find<MyData>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "My Tasks",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
          ),
        ),
        body: Obx(() {
          if (d.data.isEmpty) {
            return const Center(child: Text('No data found'));
          }

          return ListView.builder(
            itemCount: d.data.length,
            itemBuilder: (context, index) {
              final task = d.data[index];
              final isMark = task["isMark"] == true;
              return ListTile(
                title: Text(task["title"]?.toString() ?? "No title"),
                subtitle: Text(task["category"]?.toString() ?? "No category"),
                trailing: IconButton(
                  icon: Icon(
                    isMark ? Icons.check_circle : Icons.circle_outlined,
                    color: isMark ? Colors.green : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    final current = d.data[index]['isMark'] as bool? ?? false;
                    d.data[index]['isMark'] = !current;
                    d.data.refresh();
                  },
                ),
              );
            },
          );
        }),

        floatingActionButton: SizedBox(
          width: 55,
          height: 55,
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            shape: CircleBorder(),
            onPressed: () {
              Get.off(() => ScreenForm());
            },
            child: Text(
              "+",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
